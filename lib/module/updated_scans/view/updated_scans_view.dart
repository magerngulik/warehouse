import 'package:flutter/material.dart';
import '../controller/updated_scans_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class UpdatedScansView extends StatelessWidget {
  final Map? data;
  const UpdatedScansView({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdatedScansController>(
      init: UpdatedScansController(data: data),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: WarehouseAppbar(
              title: "${data!["head_name"]} Locations",
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 24.0,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    size: 24.0,
                  ),
                ),
              ]),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: const Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MBoxDescription(
                          title: "All Stock",
                          countItem: "1500",
                          colors: Colors.green),
                      SizedBox(
                        width: 20.0,
                      ),
                      MBoxDescription(
                        title: "Status",
                        countItem: "Minim",
                        colors: Colors.red,
                      )
                    ],
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
