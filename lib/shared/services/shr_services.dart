// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferences _prefs;

  // Constructor untuk menginisialisasi SharedPreferences
  SharedPreferencesService(
    this._prefs,
  ) {
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Method untuk menyimpan data String
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  // Method untuk mengambil data String
  String getString(String key) {
    return _prefs.getString(key) ??
        ""; // Default value jika key tidak ditemukan
  }

  // Method untuk menyimpan data bool
  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  // Method untuk mengambil data bool
  bool getBool(String key) {
    return _prefs.getBool(key) ??
        false; // Default value jika key tidak ditemukan
  }
}
