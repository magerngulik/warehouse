import 'package:flutter/material.dart';
import '../controller/detail_item_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class DetailItemView extends StatelessWidget {
  const DetailItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailItemController>(
      init: DetailItemController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("DetailItem"),
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
