import 'package:flutter/material.dart';
import '../controller/report_menu_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class ReportMenuView extends StatelessWidget {
  const ReportMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportMenuController>(
      init: ReportMenuController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("ReportMenu"),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: const [],
              ),
            ),
          ),
        );
      },
    );
  }
}
