import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_warehouse/main.dart';
import 'package:skripsi_warehouse/shared/color/m_dialog.dart';
import '../view/head_location_view.dart';

class HeadLocationController extends GetxController {
  HeadLocationView? view;

  @override
  void onInit() {
    super.onInit();
    getDataHead();
  }

  RxList<Map<String, dynamic>> data = <Map<String, dynamic>>[].obs;

  RxBool isLoading = true.obs;
  Future getDataHead() async {
    try {
      final dataHead = await supabase.from('head_location').select('*');
      data.assignAll(List<Map<String, dynamic>>.from(dataHead));
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  deleteHeadLocationData(int id) {
    Get.dialog(MDialogConfrmationDelete(
      onTap: () async {
        Get.showOverlay(
          loadingWidget: const Center(
            child: CircularProgressIndicator(),
          ),
          asyncFunction: () async {
            try {
              await supabase.from('head_location').delete().match({'id': id});
              getDataHead();
            } catch (e) {
              Get.dialog(MDialogFailed(message: e.toString()));
            }
          },
        );
      },
    ));
  }
}
