import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/main.dart';
import '../view/admin_manage_user_view.dart';

class AdminManageUserController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getDataUser();
  }

  AdminManageUserView? view;

  bool isLoading = false;
  var user = [];
  String roleUser = "";

  getDataUser() async {
    isLoading = true;
    update();
    try {
      final data = await supabase
          .from('user')
          .select('*')
          .eq('status', 'aktif')
          .order('created_at', ascending: true);

      user = List.from(data);
    } catch (e) {
      Get.dialog(QDialog(
        message: "Gagal mendapatkan data user: $e",
        ontap: () {
          Get.back();
          Get.back();
        },
      ));
    }
    isLoading = false;
    update();
  }

  showDialogDelete(String uuid) {
    Get.dialog(QDialogDelete(
      message: "apakah anda yakin untuk menghapus data user ini?",
      ontap: () {
        Get.back();
        deleteData(uuid);
      },
    ));
  }

  deleteData(String uuid) {
    Get.showOverlay(
      loadingWidget: const QLoadingWidget(),
      asyncFunction: () async {
        try {
          Map dataChange = {"status": 'tidak'};

          await supabase.from('user').update(dataChange).match({'id': uuid});
        } catch (e) {
          Get.dialog(QDialog(message: "error saat menghapus data : $e"));
        }

        Get.back();
        Get.back();
      },
    );
  }
}
