import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/main.dart';
import '../view/admin_list_items_view.dart';

class AdminListItemsController extends GetxController {
  AdminListItemsView? view;

  var isLOading = false;

  showDialogDelete(int id) {
    Get.dialog(QDialogDelete(
      message: "Apakah anda yakin untuk menghapus data ini?",
      ontap: () {
        debugPrint("id yang akan di hapus: $id");
        onDeleteItem(id);
        Get.back();
      },
    ));
  }

  onDeleteItem(int id) async {
    isLOading = true;
    update();
    await Future.delayed(const Duration(seconds: 2));
    debugPrint("ini akhir nya");
    try {
      var data = await supabase.from('part').delete().match({'id': id});
      debugPrint(data);
      Get.dialog(const QDialog(message: "data berhasil di hapus"));
    } catch (e) {
      Get.dialog(const QDialog(message: "Terjadi error ketika hapus data"));
    }
    isLOading = false;
    update();
  }
}
