import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/shared/services/shr_services.dart';
import '../../../main.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // textEmail.text = "ilham@gmail.com";
    textEmail.text = "admin@admin.com";
    textPassword.text = "password";
  }

  @override
  void onClose() {
    debugPrint("berhasil di clone halaman login");
    super.onClose();
  }

  LoginView? view;

  TextEditingController textEmail = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  doLogin() async {
    var isExist = await checkUserExist(textEmail.text);

    if (isExist) {
      Get.showOverlay(
        loadingWidget: const Center(
          child: CircularProgressIndicator(),
        ),
        asyncFunction: () async {
          try {
            await supabase.auth.signInWithPassword(
                password: textPassword.text, email: textEmail.text);
            final user = supabase.auth.currentUser!.id;

            final profile =
                await supabase.from('user').select('*').eq('id', user);
            // local.saveString("uuid", value)
            var uuid = profile[0]['id'];
            var email = profile[0]['email'];
            var username = profile[0]['username'];
            var role = profile[0]['role'];

            saveToLocal(
                uuid: uuid, email: email, username: username, role: role);

            if (role == "admin") {
              Get.offAll(const AdminMenuView());
            } else {
              Get.offAll(const DashboardView());
            }
          } catch (e) {
            debugPrint(e.toString());
            Get.dialog(const QDialog(
                message:
                    "Gagal Login coba check email dan password dengan benar"));
          }
        },
      );
    } else {
      try {
        await supabase.auth.signInWithPassword(
            password: textPassword.text, email: textEmail.text);
        final id = supabase.auth.currentUser!.id;
        final email = supabase.auth.currentUser!.email;
        final username = supabase.auth.currentUser!.email;

        final newUser = {
          'id': id, // Generate UUID
          'email': email,
          'username': username, // Ambil bagian sebelum '@' dari alamat email
          'role': 'user',
        };

        final insertResponse = await supabase.from('user').upsert([
          newUser,
        ]);

        if (insertResponse.error != null) {
          debugPrint('Gagal menambahkan pengguna: ${insertResponse.error}');
        } else {
          saveToLocal(
              uuid: id, email: email!, username: username!, role: "user");
          Get.to(const DashboardView());
        }
      } catch (e) {
        Get.dialog(QDialog(message: "Ada kesalahan server: ${e..toString()}"));
      }
    }
  }

  createNewUser() {}

  Future<bool> checkUserExist(String email) async {
    var response = await supabase.from('user').select("*").eq('email', email);
    debugPrint("data response: $response");

    if (response.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  saveToLocal(
      {required String uuid,
      required String email,
      required String username,
      required String role}) async {
    final prefs = await SharedPreferences.getInstance();
    var local = SharedPreferencesService(prefs);
    local.saveString("uuid", uuid);
    local.saveString("email", email);
    local.saveString("username", username);
    local.saveString("role", role);
  }

  void exitApp() {
    SystemNavigator.pop();
  }
}
