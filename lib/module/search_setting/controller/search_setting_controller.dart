import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_warehouse/core.dart';
import '../view/search_setting_view.dart';

class SearchSettingController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLoadSetting();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  SearchSettingView? view;

  List<String> dataSearch = ["part number", "ruang kosong"];
  String searchField = "part number";
  bool isAcending = true;

  bool isMinim = true;

  doSaveSetting() async {
    var prefh = await SharedPreferences.getInstance();
    var local = SharedPreferencesService(prefh);
    local.saveString("searchField", searchField);
    local.saveBool("isAcending", isAcending);
    local.saveBool("isMinim", isMinim);
    update();
    Get.back();
  }

  getLoadSetting() async {
    var prefh = await SharedPreferences.getInstance();
    var local = SharedPreferencesService(prefh);
    searchField = local.getString("searchField");
    isAcending = local.getBool("isAcending");
    isMinim = local.getBool("isMinim");
    update();
  }

  doPrintData() {
    debugPrint("search field = $searchField");
    debugPrint("is ascanding = $isAcending");
  }
}
