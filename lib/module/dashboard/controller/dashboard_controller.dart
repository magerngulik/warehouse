import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/main.dart';
import 'package:skripsi_warehouse/module/input_parts/widget/q_dialog_logout.dart';
import 'package:skripsi_warehouse/shared/services/auth_services.dart';
import 'package:skripsi_warehouse/shared/widget/loading/q_loading.dart';
import '../view/dashboard_view.dart';

class DashboardController extends GetxController {
  @override
  void onInit() {
    deleyProcess();
    super.onInit();
  }

  DashboardView? view;
  String username = "";
  String? userId;
  String? email;

  deleyProcess() async {
    Future.delayed(const Duration(seconds: 3));
    await getuser();
  }

  getuser() async {
    try {
      userId = supabase.auth.currentUser!.id;
      debugPrint("userid : $userId");

      final data =
          await supabase.from('user').select("*").eq('id', userId).single();
      username = data['username'] ?? '';
      email = data['email'] ?? '';
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  var menu = [
    {"menu": "List Part Area F", "onclick": const ListPartView()},
    {"menu": "Report", "onclick": const ReportView()}
  ];

  doLogout() async {
    var data = await AuthServices.logout();

    if (data) {
      Get.offAll(const LoginView());
    } else {
      Get.dialog(QDialog(message: AuthServices.errorLogout));
    }
  }

  openDialogLogout() {
    Get.showOverlay(
      loadingWidget: const QLoadingWidget(),
      asyncFunction: () async {
        Get.dialog(QDialogLogout(
          message: "apakah anda yakin ingin keluar?",
          ontap: () {
            doLogout();
          },
        ));
      },
    );
  }
}
