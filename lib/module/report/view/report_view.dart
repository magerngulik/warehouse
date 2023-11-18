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
          body: SingleChildScrollView(
            child: Container(
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Report Data",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      QButtonDownload(
                          ontap: () {
                            debugPrint("ontap 1");
                            controller.testGenerate();
                          },
                          image: "assets/icons/exl.png",
                          title: "Download (xlsx)"),
                      QButtonDownload(
                          ontap: () {
                            debugPrint("ontap 2");
                          },
                          image: "assets/icons/pdf.png",
                          title: "Download (xlsx)")
                    ],
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
