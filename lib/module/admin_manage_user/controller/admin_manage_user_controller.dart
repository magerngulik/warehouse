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
      final data = await supabase.from('user').select('*');

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
}
