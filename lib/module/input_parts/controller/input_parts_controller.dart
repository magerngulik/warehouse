import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:skripsi_warehouse/module/input_parts/widget/q_dialog.dart';
import 'package:skripsi_warehouse/module/input_parts/widget/q_dialog_no_empty.dart';
import '../../../main.dart';
import '../view/input_parts_view.dart';

class InputPartsController extends GetxController {
  InputPartsView? view;
  TextEditingController productNumberController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController minimalStockController = TextEditingController();

  inputPartData() async {
    debugPrint("data print");
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

    try {
      await supabase.from('part').insert({
        'part_number': productNumberController.text,
        'part_name': productNameController.text,
        'stock': stockController.text,
        'minimum': minimalStockController.text,
      });

      Get.dialog(const QDialog(message: "berhasil input data"));
    } catch (e) {
      debugPrint(e.toString());
      if (e is PostgrestException) {
        final errorMessage = e.message;
        Get.dialog(QDialongNoEmpty(title: errorMessage));
      }
    }
  }
}
