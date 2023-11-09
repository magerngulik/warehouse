import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_warehouse/main.dart';
import '../view/add_head_location_view.dart';

class AddHeadLocationController extends GetxController {
  AddHeadLocationView? view;
  final int id;
  final Map data;

  AddHeadLocationController(this.id, this.data);

  var maxLantai = TextEditingController();
  var maxRak = TextEditingController();
  var locationName = TextEditingController();

  inputHeadLocation() async {
    int lantai = int.parse(maxLantai.text);
    int rak = int.parse(maxRak.text);
    try {
      await supabase.rpc('add_new_head_location',
          params: {"new_lantai": lantai, "new_rak": rak});
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //untuk melihat apakah ada data atau tidak
  checkData() {
    if (id != 0) {
      var item = data;
      debugPrint("data = $item");
      maxLantai.text = item["max_lantai"].toString();
      maxRak.text = item["max_rak"].toString();
      locationName.text = item["location_name"];
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkData();
  }

  addNewHeadLocation() {
    if (maxLantai.text == "" || maxRak.text == "") {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Warning",
          message: 'Max Lantai atau Max Rak tidak boleh kosong',
          icon: Icon(Icons.warning, color: Colors.white),
          duration: Duration(seconds: 3),
        ),
      );
    }
    if (id != 0) {
      Get.showOverlay(
        loadingWidget: const Center(child: CircularProgressIndicator()),
        asyncFunction: () async {
          updatedHeadLocationTable(id);
        },
      );
    } else {
      try {
        createHeadLocationTable(
            int.parse(maxLantai.text), int.parse(maxRak.text));
      } catch (e) {
        debugPrint("error: ${e.toString()}");
      }
    }
  }

  //melakukan editing tabel
  updatedHeadLocationTable(int id) async {
    try {
      await supabase.from("head_location").update({
        'max_lantai': maxLantai.text,
        'max_rak': maxRak.text,
      }).eq('id', id);
      Get.back();
      // debugPrint("response: $response");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //membuat table location baru
  Future<void> createHeadLocationTable(int maxLantai, int maxRak) async {
    var newLocation = await getNextLocationName();
    // print("new location : $newLocation");
    Get.showOverlay(
      loadingWidget: const Center(
        child: CircularProgressIndicator(),
      ),
      asyncFunction: () async {
        try {
          debugPrint("Kodingan berjalan");
          await supabase.from('head_location').insert({
            'location_name': newLocation,
            'max_lantai': maxLantai,
            'max_rak': maxRak,
          });
          Get.back();
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
  }

  Future<String> getNextLocationName() async {
    try {
      final response = await supabase
          .from('head_location')
          .select('location_name')
          .order('created_at', ascending: false)
          .limit(1);
      final previousLocationName = response[0]['location_name'];
      final nextLocationName =
          'F${int.parse(previousLocationName.substring(1)) + 1}';
      return nextLocationName;
    } catch (e) {
      return e.toString();
    }
  }
}
