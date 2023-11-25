import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../view/register_user_view.dart';

class RegisterUserController extends GetxController {
  RegisterUserView? view;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPsController = TextEditingController();
  var jobLevel = TextEditingController();
  var positon = TextEditingController();
  var isLoading = false;

  var adminManageUserController = Get.put(AdminManageUserController());

  String errorText = "";

  doRegister() async {
    if (nameController.text == "") {
      errorText = "username tidak boleh kosong";
    } else if (emailController.text == "") {
      errorText = "email tidak boleh kosong";
    } else if (passwordController.text == "") {
      errorText = "password tidak boleh kosong";
    } else if (confirmPsController.text == "") {
      errorText = "confirm password tidak boleh kosong";
    } else if (jobLevel.text == "") {
      errorText = "job level harus di pilih";
    } else if (positon.text == "") {
      errorText = "posisi harus di pilih";
    } else if (confirmPsController.text != passwordController.text) {
      errorText = "password tidak sama";
    }

    if (errorText != "") {
      Get.dialog(QDialog(
        message: errorText,
      ));
      errorText = "";
      update();
      return;
    } else {
      isLoading = true;
      update();
      final AuthResponse res = await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
      );

      final User? user = res.user;

      if (user != null) {
        try {
          await supabase.from('user').upsert([
            {
              'id': user.id,
              'email': user.email,
              'username': nameController.text,
              'position': positon.text,
              'job_level': jobLevel.text,
            },
          ]);

          Get.dialog(QDialog(
            message: "Berhasil daftar silahkan login",
            ontap: () {
              adminManageUserController.getDataUser();
              Get.back();
              Get.back();
            },
          ));
        } catch (e) {
          Get.dialog(QDialog(message: "Gagal Register - Error: $e"));
        }
      }
    }
    isLoading = false;
    update();
  }
}
