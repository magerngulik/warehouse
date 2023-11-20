import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/main.dart';
import '../view/location_part_detail_view.dart';

class LocationPartDetailController extends GetxController {
  LocationPartDetailView? view;
  Map data;
  LocationPartDetailController({required this.data});

  String locationName = "";
  int maxLantai = 0;
  int maxRak = 0;

  @override
  void onInit() {
    super.onInit();
    setDataHeat();
  }

  setDataHeat() {
    locationName = data['location_name'];
    maxLantai = data['max_lantai'];
    maxRak = data['max_rak'];
  }

  deleteData(int id) async {
    try {
      await supabase.from('location').delete().match({'id': id});
      Get.dialog(const QDialog(message: "Data berhasil di hapus"));
      update();
    } catch (e) {
      Get.dialog(QDialog(message: "Gagal Delete: ${e.toString()}"));
    }
  }
}
