// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:skripsi_warehouse/core.dart';

import '../controller/input_parts_controller.dart';

class InputPartsView extends StatelessWidget {
  final Map? item;
  const InputPartsView({
    Key? key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputPartsController>(
      init: InputPartsController(item),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: WarehouseAppbar(
              title: item != null ? "Updated a Part" : "Add a Part"),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  WarehouseTextfield(
                      hintTitle: "Part Number",
                      controller: controller.productNumberController,
                      readOnly: item != null),
                  WarehouseTextfield(
                      hintTitle: "Part Name",
                      controller: controller.productNameController),
                  WarehouseTextfield(
                      hintTitle: "Stock",
                      controller: controller.stockController,
                      readOnly: item == null),
                  WarehouseTextfield(
                      hintTitle: "Minimum",
                      controller: controller.minimalStockController),
                  const SizedBox(
                    height: 20.0,
                  ),
                  WarehouseButton(
                      ontap: () {
                        controller.inputPartData();
                      },
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
