import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/main.dart';
import 'package:skripsi_warehouse/module/report/view/report_view.dart';
import '../view/list_part_view.dart';

class ListPartController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getHeadTable();
  }

  ListPartView? view;

  var menu = [].obs;

  getHeadTable() async {
    try {
      var data = await supabase
          .from("head_location")
          .select("*")
          .order('created_at', ascending: true);
      // debugPrint("data: $data");
      menu = RxList<Map<String, dynamic>>.from(data);
      // debugPrint("menu: $menu");
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
