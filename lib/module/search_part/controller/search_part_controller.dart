import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/main.dart';
import 'package:skripsi_warehouse/shared/services/shr_services.dart';
import '../view/search_part_view.dart';

class SearchPartController extends GetxController {
  SearchPartView? view;

  @override
  void onInit() {
    super.onInit();
    cekLocalStorage();
  }

  bool isLoading = false;
  Debouncer debouncer = Debouncer(delay: const Duration(milliseconds: 10));
  var textSearch = TextEditingController();
  var log = Logger();
  String fieldName = "";
  bool isAscending = false;
  bool isMinim = false;
  bool partFilters = true;
  var dataLocation = [];
  var dataPart = [];

  cekLocalStorage() async {
    var prefh = await SharedPreferences.getInstance();
    var local = SharedPreferencesService(prefh);

    fieldName = local.getString("searchField");
    if (fieldName == "") {
      fieldName = "part number";
      partFilters = true;
    } else if (fieldName == "part number") {
      partFilters = true;
    } else {
      partFilters = false;
    }

    isAscending = local.getBool("isAcending");
    isMinim = local.getBool("isMinim");

    debugPrint("field name = $fieldName");
    debugPrint("is ascending = $isAscending");
    debugPrint("is minim = $isMinim");
    update();
  }

  cekLoading() async {
    isLoading = true;

    update();
    await Future.delayed(const Duration(seconds: 1));
    isLoading = false;
    update();
  }

  serchData() {
    Get.showOverlay(
        loadingWidget: const QLoadingWidget(),
        asyncFunction: () async {
          debouncer.call(
            () {
              if (fieldName == "part number") {
                debugPrint("kondisi location name");
                debugPrint("data field: $fieldName");
                processSearchLocation();
              } else {
                debugPrint("kondisi part name");
                debugPrint("data field: $fieldName");
                //search ruang kosong
                processSearchPart();
              }
            },
          );
        });
  }

  processSearchLocation() async {
    try {
      var data = await supabase
          .from("location")
          .select(
            "*, transaction(*, part(*))",
          )
          .eq("quantity", 0)
          .like("head_name", "%${textSearch.text}%")
          .order("created_at", ascending: isAscending);
      log.f(data);
    } catch (e) {
      debugPrint(e.toString());
    }
    update();
  }

  processSearchPart() async {
    try {
      final data = await supabase.rpc('searchpartnumber',
          params: {"part_number_params": textSearch.text});

      log.d(data);

      dataPart = List<Map<String, dynamic>>.from(data);
      log.i(dataPart);
    } catch (e) {
      debugPrint(e.toString());
    }
    update();
  }

  // processSearchPart() async {
  //   try {
  //     var data = await supabase
  //         .from("part")
  //         .select(
  //           "*, transaction(*, location(*))",
  //         )
  //         .like("part_number", "%${textSearch.text}%")
  //         .order("created_at", ascending: isAscending);
  //     log.f(data);
  //     dataPart = List<Map<String, dynamic>>.from(data);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  //   update();
  // }
}
