// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/main.dart';
import 'package:skripsi_warehouse/shared/widget/loading/q_loading.dart';
import 'package:skripsi_warehouse/shared/widget/qr_scanner/show_qrcode_scanner.dart';

import '../view/input_scans_view.dart';

class InputScansController extends GetxController {
  @override
  void onClose() {
    super.onClose();
    partNumberController.dispose();
    locationFieldController = "";
    quantityController.dispose();
  }

  InputScansView? view;
  Map? data;
  InputScansController({
    this.data,
  });

  //variable datang
  var partNumberController = TextEditingController();
  var locationFieldController = "";
  var idLocationController = 0;
  var quantityController = TextEditingController();

  int partNumberid = 0;
  int? stock;

  int newStock = 0;

  int idHead = 0;
  List<Map<String, dynamic>> dataLocationReady = [];

  var log = Logger();
  @override
  void onInit() {
    super.onInit();
    log.d(data);
    cekData();
    getDataHeadLocation();

    getDataLocation();
  }

  getDataHeadLocation() async {
    if (data!['head_location_id'] == 0) {
      await Future.delayed(const Duration(seconds: 3));
      Get.dialog(const QDialog(message: "gagal mendapatkan lokasi"));
    } else {
      idHead = data!['head_location_id'];
      debugPrint("id head: $idHead");
    }
  }

  cekData() {
    if (data == null) {
      log.d("data kosong");
    } else {
      log.d(data);
    }
  }

  scanPartNumber() async {
    partNumberController.text = await showQrcodeScanner(Get.context!) ?? "";
    debugPrint("part number : ${partNumberController.text}");
    update();
  }

  getDataLocation() async {
    Future.delayed(const Duration(seconds: 2));
    if (idHead != 0) {
      try {
        var datasorces = await supabase
            .from("location")
            .select("*")
            .eq("quantity", 0)
            .eq("head_location_id", idHead);
        debugPrint("ready data: $datasorces");
        log.d(datasorces);
        dataLocationReady = List<Map<String, dynamic>>.from(datasorces);

        update();
        debugPrint("ini data location; $dataLocationReady");
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      Get.dialog(const QDialog(message: "gagal mendapatkan head id"));
    }
  }

  cekSubmit() async {
    Get.showOverlay(
      loadingWidget: const QLoadingWidget(),
      asyncFunction: () async {
        debugPrint("part number: ${partNumberController.text}");
        debugPrint("location: $locationFieldController");
        debugPrint("quantity: ${quantityController.text}");

        if (partNumberController.text == "") {
          Get.dialog(
              const QDialog(message: "Data part number tidak boleh kosong"));
        } else if (locationFieldController == "") {
          Get.dialog(const QDialog(message: "Data lokasi tidak boleh kosong"));
        } else if (quantityController.text == "") {
          Get.dialog(
              const QDialog(message: "Data Quantity tidak boleh kosong"));
        }
        await cekPartNumber(partNumber: partNumberController.text);

        Map dataInput = {
          "location_id": idLocationController,
          "part_id": partNumberid
        };

        await supabase.from('transaction').insert(dataInput);

        await supabase
            .from('location')
            .update({'quantity': int.parse(quantityController.text)}).match(
                {'id': idLocationController});

        if (stock != null) {
          newStock = (stock ?? 0) + int.parse(quantityController.text);
          update();
        }
        debugPrint("new stock= $newStock");

        await supabase
            .from("part")
            .update({"stock": newStock}).match({"id": partNumberid});

        Get.dialog(QDialog(
          message: "Data berhasil di input",
          ontap: () {
            Get.back();
            Get.back();
          },
        ));
      },
    );
  }

  cekPartNumber({required String partNumber}) async {
    try {
      var response = await supabase
          .from("part")
          .select("id,stock")
          .eq("part_number", partNumber)
          .single();

      // Periksa apakah data kosong
      if (response.isEmpty) {
        Get.dialog(const QDialog(
            message: "Part number yang ada masukan tidak di temukan"));
      } else {
        partNumberid = response['id'];
        stock = response['stock'];
        debugPrint(partNumber);
        debugPrint("response stock ${response['stock']}");
        update();
      }
    } catch (e) {
      // Tangani kesalahan jika terjadi
      print("Terjadi kesalahan: $e");
    }
  }
}
