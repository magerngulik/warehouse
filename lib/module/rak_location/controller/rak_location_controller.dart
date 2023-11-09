// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/main.dart';

import '../view/rak_location_view.dart';

class RakLocationController extends GetxController {
  @override
  void onClose() {
    super.onClose();
    terisi = 0;
    kosong = 0;
  }

  RakLocationView? view;
  Map data;
  RakLocationController({
    this.view,
    required this.data,
  });

  String locationName = "";
  int idHead = 0;
  int maxRak = 0;
  int maxLantai = 0;
  int terisi = 0;
  int kosong = 0;
  String headTag = "";
  bool isLoading = false;
  var log = Logger();

  //list data location filters
  var listData = [].obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint("data hari head: $data");
    locationName = data['location_name'];
    idHead = data['id'];
    maxLantai = data['max_lantai'];
    maxRak = data['max_rak'];
    var list =
        locationName.split('-'); // memisahkan string berdasarkan tanda hubung
    headTag = list[0];

    debugPrint(
        "location name: $locationName, id: $idHead, max lantai: $maxLantai, max rak: $maxRak");
    getDataLocation();
  }

  getDataLocation() async {
    isLoading = true;
    try {
      var data = await supabase
          .from("location")
          .select("*,transaction(*,part(*))")
          .eq("head_location_id", idHead);

      listData = RxList<Map<String, dynamic>>.from(data);
      isLoading = false;
      update();
      log.d(listData);
      debugPrint("ini list data =  $listData");
      debugPrint("Is Loading: $isLoading");
    } catch (e) {
      isLoading = false;
      update();
      debugPrint("Is Loading: $isLoading");
      Get.dialog(QDialog(message: "Terjadi error pada server: $e"));
    }
  }

  String extractDesiredPart(String input) {
    List<String> parts = input.split("-");

    if (parts.length >= 2) {
      String desiredPart = parts.sublist(1).join("-");
      return desiredPart;
    } else {
      return "Format string tidak sesuai";
    }
  }

  tambahDataTerisi({required int quantity}) {
    if (quantity != 0) {
      terisi++;
      debugPrint("data terisi: $terisi");
    } else {
      kosong++;
      debugPrint("data terisi: $kosong");
    }
  }
}
