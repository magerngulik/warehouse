import 'package:flutter/material.dart';
import '../controller/input_parts_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class InputPartsView extends StatelessWidget {
  const InputPartsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputPartsController>(
      init: InputPartsController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: const WarehouseAppbar(title: "Add a Part"),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  WarehouseTextfield(
                      hintTitle: "Part Number",
                      controller: controller.productNumberController),
                  WarehouseTextfield(
                      hintTitle: "Part Name",
                      controller: controller.productNameController),
                  WarehouseTextfield(
                      hintTitle: "Stock",
                      controller: controller.stockController,
                      readOnly: true),
                  WarehouseTextfield(
                      hintTitle: "Minimum",
                      controller: controller.minimalStockController),
                  const SizedBox(
                    height: 20.0,
                  ),
                  WarehouseButton(
                      ontap: () async => controller.inputPartData(),
                      title: "Simpan"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
