import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skripsi_warehouse/module/input_parts/widget/q_dialog_delete.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:skripsi_warehouse/module/input_parts/widget/q_dialog.dart';
import 'package:skripsi_warehouse/module/input_parts/widget/q_dialog_no_empty.dart';
import '../../../main.dart';
import '../view/input_parts_view.dart';

class InputPartsController extends GetxController {
  final Map? item;
  InputPartsController(this.item);
  var log = Logger();

  @override
  void onInit() {
    super.onInit();
    stockController.text = 0.toString();
    if (item != null) {
      log.w(item);
      productNumberController.text = item!['part_number'];
      productNameController.text = item!['part_name'];
      stockController.text = item!['stock'].toString();
      minimalStockController.text = item!['minimum'].toString();
      idPart = item!["id"];
    }
  }

  InputPartsView? view;
  TextEditingController productNumberController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController minimalStockController = TextEditingController();
  int? idPart;
  bool isLoading = false;

  inputPartData() async {
    String error = "";
    RegExp regex = RegExp(r'^-?[0-9]+$');

    if (productNumberController.text == "" ||
        productNumberController.text.isEmpty) {
      error = "product number";
    } else if (productNameController.text == "") {
      error = "product name";
    } else if (stockController.text == "") {
      error = "stock";
    } else if (minimalStockController.text == "") {
      error = "minimum stock";
    } else if (!regex.hasMatch(stockController.text)) {
      error = "stock harus berupa angka";
    } else if (!regex.hasMatch(minimalStockController.text)) {
      error = "minimum stock harus berupa angka";
    }

    if (error.isNotEmpty) {
      Get.dialog(QDialongNoEmpty(title: error));
      return;
    }

    if (item == null) {
      var test = item == null;
      debugPrint(test.toString());
      try {
        await supabase.from('part').insert({
          'part_number': productNumberController.text,
          'part_name': productNameController.text,
          'stock': stockController.text,
          'minimum': minimalStockController.text,
        });

        Get.dialog(QDialog(
          message: "berhasil input data",
          ontap: () {
            Get.back();
            Get.back();
          },
        ));
        // Get.back();
      } catch (e) {
        debugPrint(e.toString());
        if (e is PostgrestException) {
          final errorMessage = e.message;
          Get.dialog(QDialongNoEmpty(title: errorMessage));
        }
      }
    } else {
      debugPrint("kondisi update berjalan");
      if (item!['stock'] != int.parse(stockController.text)) {
        Get.dialog(QDialogDelete(
          message:
              "Apakah anda yakin untuk merubah stock yang ada, ini dapat mengakibatkan bug pada sistem",
          ontap: () {
            doUpdate();
          },
        ));
      } else {
        doUpdate();
      }
    }
  }

  doUpdate() async {
    debugPrint("kondisi update berjalan");
    try {
      Map dataChange = {
        "part_name": productNameController.text,
        "stock": stockController.text,
        "minimum": minimalStockController.text
      };

      debugPrint("ini part name ${productNameController.text}");

      await supabase.from('part').update(dataChange).match({'id': idPart});
    } catch (e) {
      debugPrint(e.toString());
      if (e is PostgrestException) {
        final errorMessage = e.message;
        Get.dialog(QDialongNoEmpty(title: errorMessage));
      }
    }
    Get.back();
    Get.back();
  }
}
