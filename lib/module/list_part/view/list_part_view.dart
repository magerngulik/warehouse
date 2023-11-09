import 'package:flutter/material.dart';
import '../controller/list_part_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class ListPartView extends StatelessWidget {
  const ListPartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListPartController>(
      init: ListPartController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: const WarehouseAppbar(title: "List Part Area Rak F"),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: List.generate(controller.menu.length, (index) {
                  var item = controller.menu[index];
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      onTap: () {
                        Get.to(RakLocationView(
                          data: item,
                        ));
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "${item['location_name']}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: baseColor,
            child: const Icon(Icons.add),
            onPressed: () {
              Get.to(const InputScansView());
            },
          ),
        );
      },
    );
  }
}
