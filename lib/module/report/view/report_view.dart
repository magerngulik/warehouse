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
          appBar: const WarehouseAppbar(title: "Report Menu"),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: baseColor),
                  )
                ],  
              ),
            ),
          ),
        );
      },
    );
  }
}
