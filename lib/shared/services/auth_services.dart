import 'package:skripsi_warehouse/main.dart';
import 'package:skripsi_warehouse/module/login/view/login_view.dart';

class AuthServices {
  static String errorLogout = "";
  static Future<bool> logout() async {
    try {
      await supabase.auth.signOut();
      return true;
    } catch (e) {
      errorLogout = e.toString();
      return false;
    }
  }
}
