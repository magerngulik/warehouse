import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/main.dart';
import 'package:skripsi_warehouse/module/input_parts/widget/q_dialog_logout.dart';
import 'package:skripsi_warehouse/shared/widget/loading/q_loading.dart';
import '../view/admin_menu_view.dart';

class AdminMenuController extends GetxController {
  AdminMenuView? view;

  List<Map<String, dynamic>> halaman = [
    {"title": "Input Part Items", "ontap": const InputPartsView()},
    {"title": "Input Head Location", "ontap": const HeadLocationView()},
    {"title": "Input Location", "ontap": const LocationPartView()},
    {"title": "List Part Area", "ontap": const ListPartView()},
    {"title": "Manage Part Data", "ontap": const AdminListItemsView()},
  ];

  var isLoading = false.obs;

  openDialogLogout() {
    Get.showOverlay(
      loadingWidget: const QLoadingWidget(),
      asyncFunction: () async {
        Get.dialog(QDialogLogout(
          message: "apakah anda yakin ingin keluar?",
          ontap: () {
            logout();
          },
        ));
      },
    );
  }

  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
      Get.offAll(const LoginView());
    } catch (e) {
      Get.dialog(QDialog(message: "logout error: ${e.toString()}"));
    }
  }
}
