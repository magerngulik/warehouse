// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../view/updated_scans_view.dart';

class UpdatedScansController extends GetxController {
  var log = Logger();

  @override
  void onInit() {
    checkIntiData();
    super.onInit();
  }

  UpdatedScansView? view;
  Map? data;

  UpdatedScansController({
    this.data,
  });

  checkIntiData() {
    if (data != null) {
      debugPrint("$data");
      log.d(data);
      var transaction = data!["transaction"][0];
      var part = transaction['part'];
      log.d(transaction);
      log.d(part);
    }
  }

  updateViewDataPart() {
    Future.delayed(const Duration(seconds: 2));
  }
}
