// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:skripsi_warehouse/core.dart';

import '../../../main.dart';
import '../controller/input_scans_controller.dart';

class InputScansView extends StatelessWidget {
  final Map? data;

  final Map? dataUpdate;
  const InputScansView({Key? key, this.data, this.dataUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputScansController>(
      init: InputScansController(data: data, dataUpdate: dataUpdate),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: WarehouseAppbar(
              title: (dataUpdate == null) ? "Input Scans" : "Update Scans"),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(),
                    child: TextFormField(
                      initialValue: null,
                      readOnly: (dataUpdate != null) ? true : false,
                      controller: controller.partNumberController,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            debugPrint("tombol ditekan");
                            controller.scanPartNumber();
                          },
                          child: const Icon(Icons.qr_code),
                        ),
                        filled: true,
                        fillColor: textfieldColor,
                        hintText: "PART NUMBER",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: textfieldColor)),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  (dataUpdate != null)
                      ? Container()
                      : Container(
                          key: Key("key_${controller.idHead}"),
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropDownTextField(
                            padding: EdgeInsets.zero,
                            clearOption: false,
                            dropDownItemCount: 8,
                            searchShowCursor: false,
                            enableSearch: true,
                            initialValue: (dataUpdate != null)
                                ? DropDownValueModel(
                                    name: controller.headName,
                                    value: controller.idHead)
                                : null,
                            textFieldDecoration: InputDecoration(
                              suffixIcon: const Icon(Icons.qr_code),
                              filled: true,
                              fillColor: textfieldColor,
                              hintText: "LOCATION",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: textfieldColor)),
                            ),
                            searchKeyboardType: TextInputType.text,
                            dropDownList: List.generate(
                                controller.dataLocationReady.length, (index) {
                              debugPrint(
                                  "data id: ${controller.dataLocationReady.length}");
                              var itemLocation =
                                  controller.dataLocationReady[index];
                              return DropDownValueModel(
                                  name: itemLocation["head_name"],
                                  value: itemLocation["id"]);
                            }),
                            onChanged: (dataval) {
                              controller.locationFieldController = dataval.name;
                              controller.idLocationController = dataval.value;
                            },
                          ),
                        ),
                  (dataUpdate != null)
                      ? Container()
                      : const SizedBox(
                          height: 10.0,
                        ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(),
                    child: TextFormField(
                      initialValue: null,
                      controller: controller.quantityController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: textfieldColor,
                        hintText: "QUANTITY",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: textfieldColor)),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 15,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: baseColor),
                      onPressed: () async {
                        if (dataUpdate == null) {
                          controller.cekSubmit();
                        } else {
                          debugPrint("update statement");
                          controller.doUpdate();
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
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
