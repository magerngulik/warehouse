// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:skripsi_warehouse/core.dart';

import '../controller/report_controller.dart';

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
          body: controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: baseColor),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 150.0,
                            width: 150.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/icons/inbox.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  8.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const QtitleReport(title: "Report Data"),
                      QButtonDownload(
                          ontap: () {
                            controller.generateReportData();
                          },
                          image: "assets/icons/exl.png",
                          title: "Download (xlsx)"),
                      const QtitleReport(title: "Transaction Data"),
                      QButtonDownload(
                          ontap: () {
                            controller.generateTransactionData();
                          },
                          image: "assets/icons/exl.png",
                          title: "Download (xlsx)"),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class QtitleReport extends StatelessWidget {
  final String title;
  const QtitleReport({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class QButtonDownload extends StatelessWidget {
  final Function() ontap;
  final String image;
  final String title;
  const QButtonDownload({
    Key? key,
    required this.ontap,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ontap(),
      child: Card(
        margin: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              height: 50.0,
              width: 50.0,
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    image,
                  ),
                  fit: BoxFit.fitHeight,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    8.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
