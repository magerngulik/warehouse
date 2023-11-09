// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/main.dart';
import 'package:skripsi_warehouse/shared/services/warehouse_services.dart';

import '../view/add_location_part_view.dart';

class AddLocationPartController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    cekData();
    cekQuantity();
  }

  AddLocationPartView? view;
  Map data;
  int? quantity;

  AddLocationPartController({
    this.view,
    required this.data,
    this.quantity,
  });
  String headName = "";
  var statusFalse = false.obs;
  var isEmptyData = false.obs;
  var quantityController = TextEditingController();

  cekQuantity() {
    if (quantity != 0) {
      debugPrint("data quantity: $quantity");
      quantityController.text = quantity.toString();
    }
  }

  cekData() async {
    isEmptyData.value = false;
    debugPrint("data objeck: $data");
    debugPrint("data id ${data['id']}");
    try {
      var dataLast = await WarehouseServices.getLastDataLocationByForeignKey(
          tblName: "location",
          idForeign: data['id'],
          columnForeign: "head_location_id");

      debugPrint("data last ${dataLast.toString()}");
      headName = dataLast["head_name"];
      debugPrint("head_name :$headName");
    } catch (e) {
      debugPrint(e.toString());
      if (e.toString().contains("The result contains 0 rows")) {
        debugPrint("naga bonar terbang");
        isEmptyData.value = true;
        debugPrint("data head: $data");
      } else {
        return Get.dialog(
          QDialog(
              ontap: () {
                Get.back();
                Get.back();
              },
              message:
                  "ada kesalahan pada pembuatan kode, harap hubungi admin ${e.toString()} "),
        );
      }
    }
  }

  updateLocation(int id) async {
    try {
      await supabase
          .from('location')
          .update({'quantity': quantityController.text}).match({'id': id});
      Get.dialog(QDialog(
        message: "berhasil update data",
        ontap: () {
          Get.back();
          Get.back();
        },
      ));
    } catch (e) {
      Get.dialog(QDialog(message: e.toString()));
    }
  }

  inputNewData() async {
    if (isEmptyData.value == true) {
      int id = data['id'];
      var dataId = supabase.auth.currentUser!.id;
      var dataInput = {
        "head_name": "${data['location_name']}-T1-01",
        "head_location_id": id,
        "quantity": quantityController.text,
        "id_user": dataId
      };

      try {
        await supabase.from('location').insert(dataInput);
        await Get.dialog(const QDialog(message: "berhasil input data"));
        Get.back();
      } catch (e) {
        Get.dialog(QDialog(message: e.toString()));
      }
    } else {
      await cekData();
      statusFalse.value = false;
      debugPrint("ini data awal $headName");
      if (quantityController.text.isEmpty) {
        return Get.dialog(
            const QDialongNoEmpty(title: "quantity tidak boleh kosong"));
      }

      var dataCode = await getNewCode(
          data: data,
          headName: headName,
          quantityController: quantityController);
      String newCode = "";
      dataCode.fold((l) {
        Get.dialog(QDialog(
          message: l,
          ontap: () {
            Get.back();
            Get.back();
          },
        ));
      }, (r) async {
        newCode = r;
        int id = data['id'];
        var dataId = supabase.auth.currentUser!.id;
        var dataInput = {
          "head_name": newCode,
          "head_location_id": id,
          "quantity": quantityController.text,
          "id_user": dataId
        };

        try {
          await supabase.from('location').insert(dataInput);
          await Get.dialog(const QDialog(message: "berhasil input data"));
          Get.back();
        } catch (e) {
          Get.dialog(QDialog(message: e.toString()));
        }
      });
    }
  }

  Future<Either<String, String>> getNewCode(
      {required Map data,
      required String headName,
      required TextEditingController quantityController}) async {
    List<String> parts = headName.split('-');
    debugPrint("head name : $headName");

    if (parts.length == 3) {
      String headCode = parts[0];
      String jumlahLantai = parts[1];
      String jumlahRak = parts[2];
      int maxLantai = data['max_lantai'];
      int maxRak = data['max_rak'];
      debugPrint("Bagian 1: $headCode");
      debugPrint("Bagian 2: $jumlahLantai");
      debugPrint("Bagian 3: $jumlahRak");
      debugPrint("max lantai : $maxLantai");
      debugPrint("max rak : $maxRak");
      int lantai = int.parse(jumlahLantai.replaceAll(RegExp(r'[^0-9]'), ''));
      int rak = int.parse(jumlahRak);

      debugPrint("lantai: $lantai , maxLantai: $maxLantai");

      if (rak >= maxRak) {
        if (lantai >= maxLantai) {
          debugPrint("data lantai sudah maximal");
          return const Left("Jumlah lantai sudah maximal");
        } else {
          lantai++;
          rak = 1;
        }
      } else {
        rak++;
      }

      String newRakCode = formatToTwoDigits(rak);
      String newCode = "$headCode-T$lantai-$newRakCode";
      return Right(newCode);
    } else {
      return Left("ada kesalahan format lantai ${parts.toString()}");
    }
  }

  String formatToTwoDigits(int number) {
    if (number < 10) {
      return '0$number';
    } else {
      return number.toString();
    }
  }
}
