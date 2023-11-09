import 'package:flutter/material.dart';
import 'package:skripsi_warehouse/shared/widget/texfield/w_appbar.dart';
import 'package:skripsi_warehouse/shared/widget/texfield/w_button.dart';
import 'package:skripsi_warehouse/shared/widget/texfield/w_textfield.dart';
import '../controller/add_location_part_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class AddLocationPartView extends StatelessWidget {
  final Map data;
  final int? id;
  final int? quatity;
  const AddLocationPartView(
      {Key? key, required this.data, this.id, this.quatity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddLocationPartController>(
      init: AddLocationPartController(data: data, quantity: quatity ?? 0),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: WarehouseAppbar(
              title: "Add Location Part ${data['location_name']}"),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  WarehouseTextfield(
                      hintTitle: "Quantity",
                      controller: controller.quantityController),
                  WarehouseButton(
                    ontap: () {
                      if (id != null) {
                        print("status update");
                        controller.updateLocation(id!);
                      } else {
                        controller.inputNewData();
                      }
                    },
                    title: "Submit",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
