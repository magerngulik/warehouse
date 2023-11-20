import 'package:flutter/material.dart';
import '../controller/add_head_location_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class AddHeadLocationView extends StatelessWidget {
  final int? id;
  final Map? dataWidget;
  const AddHeadLocationView({Key? key, this.id, this.dataWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddHeadLocationController>(
      init: AddHeadLocationController(id ?? 0, dataWidget ?? {}),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            title: const Text(
              "Add Head Location",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  (id != null)
                      ? Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(),
                          child: TextFormField(
                            readOnly: true,
                            controller: controller.locationName,
                            initialValue: null,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: textfieldColor,
                              hintText: "LOCATION NAME",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: textfieldColor)),
                            ),
                            onChanged: (value) {},
                          ),
                        )
                      : Container(),
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(),
                    child: TextFormField(
                      controller: controller.maxLantai,
                      initialValue: null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: textfieldColor,
                        hintText: "MAX LANTAI",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: textfieldColor)),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(),
                    child: TextFormField(
                      controller: controller.maxRak,
                      initialValue: null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: textfieldColor,
                        hintText: "MAX RAK",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: textfieldColor)),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
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
                      onPressed: () => controller.addNewHeadLocation(),
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
