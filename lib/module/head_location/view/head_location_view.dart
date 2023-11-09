import 'package:flutter/material.dart';
import '../controller/head_location_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class HeadLocationView extends StatelessWidget {
  const HeadLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HeadLocationController>(
      init: HeadLocationController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: const WarehouseAppbar(title: "Head Location"),
          body: Obx(
            () => controller.isLoading.value
                ? const Center(
                    child:
                        CircularProgressIndicator()) // Tampilkan loading indicator jika isLoading true
                : controller.data.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Location Name',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Max Lantai',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Max Rak',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Action',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ListView.builder(
                              itemCount: controller.data.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              clipBehavior: Clip.none,
                              itemBuilder: (context, index) {
                                var item = controller.data[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${item["location_name"]}',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${item["max_lantai"]}',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${item["max_rak"]}',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                Get.to(AddHeadLocationView(
                                                  id: item["id"],
                                                  dataWidget: item,
                                                ))?.then((result) {
                                                  controller.getDataHead();
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                size: 24.0,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                controller
                                                    .deleteHeadLocationData(
                                                        item["id"]);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                size: 24.0,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    : const Center(
                        child: Text(
                          "Belum ada data tersedia",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: baseColor,
            child: const Icon(Icons.add),
            onPressed: () async {
              Get.to(const AddHeadLocationView())?.then((result) {
                controller.getDataHead();
              });
            },
          ),
        );
      },
    );
  }
}
