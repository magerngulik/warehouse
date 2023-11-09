import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skripsi_warehouse/main.dart';
import '../view/testing_view.dart';

class TestingController extends GetxController {
  var log = Logger();

  @override
  void onInit() {
    super.onInit();
    // getData();
    // getLastData();
    getTransaction();
  }

  TestingView? view;

  getData() async {
    try {
      final response =
          await supabase.rpc('get_locations_by_id', params: {"p_id_user": id});
      debugPrint(response.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getLastData() async {
    try {
      final response = await supabase.rpc("get_last_location", params: {
        "new_head": 24,
        "fcode": "F1",
        "current_lantai": 2,
        "current_rak": 2
      });
      debugPrint(response.toString());
      log.d(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getTransaction() async {
    try {
      var data =
          await supabase.from("location").select("*, transaction(*,part(*))");

      debugPrint("data balikan $data");
      log.d(data);
    } catch (e) {
      debugPrint("data error $e");
    }
  }
}
