import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/main.dart';
import '../view/admin_detail_user_view.dart';

class AdminDetailUserController extends GetxController {
  AdminDetailUserView? view;
  Map? data;
  AdminDetailUserController(this.data);
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var roleUserController = TextEditingController();
  var log = Logger();
  String? idUserUpdate;
  bool isLoading = false;

  var adminManagerController = Get.put(AdminManageUserController());

  @override
  void onInit() {
    super.onInit();
    log.w(data);
    if (data != null) {
      emailController.text = data!['email'];
      usernameController.text = data!['username'];
      roleUserController.text = data!['role'];
      idUserUpdate = data!['id'];

      log.i({
        "email": emailController.text,
        "username": usernameController.text,
        "role user": roleUserController.text,
        "id user": idUserUpdate,
      });
    }
  }

  doCheckValidation() async {
    if (usernameController.text == "") {
      Get.dialog(const QDialog(message: "username tidak boleh kosong"));
      return;
    } else if (roleUserController.text == "") {
      Get.dialog(const QDialog(message: "role user harus di pilih"));
    }

    log.w({
      "username": usernameController.text,
      "role user": roleUserController.text,
      "id user": idUserUpdate
    });

    Map dataChange = {
      "username": usernameController.text,
      "role": roleUserController.text
    };

    isLoading = true;
    update();

    try {
      await supabase
          .from('user')
          .update(dataChange)
          .match({'id': idUserUpdate});
      Get.dialog(QDialog(
        message: "berhasil update data",
        ontap: () {
          adminManagerController.getDataUser();
          Get.back();
          Get.back();
        },
      ));
    } catch (e) {
      Get.dialog(QDialog(message: "ada kesalahan ketika update data user:$e"));
    }

    isLoading = false;
    update();
  }
}
