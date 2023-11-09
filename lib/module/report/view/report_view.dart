import 'package:flutter/material.dart';
import '../controller/report_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class ReportView extends StatelessWidget {
  const ReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportController>(
      init: ReportController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Report"),
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
