import 'package:get/get.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/module/rak_location/widget/m_description.dart';

class RakLocationView extends StatelessWidget {
  final Map data;
  const RakLocationView({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RakLocationController>(
      init: RakLocationController(data: data),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: WarehouseAppbar(
              title: "${controller.headTag} Location",
              actions: [
                IconButton(
                  onPressed: () {
                    Get.to(const SearchPartView());
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 24.0,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.to(const SearchSettingView());
                  },
                  icon: const Icon(
                    Icons.settings,
                    size: 24.0,
                  ),
                ),
              ]),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MBoxDescription(
                          title: "Ruang Terisi",
                          countItem: controller.terisi.toString(),
                          colors: Colors.green),
                      const SizedBox(
                        width: 20.0,
                      ),
                      MBoxDescription(
                        title: "Ruang Kosong",
                        countItem: controller.kosong.toString(),
                        colors: Colors.red,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.headTag} Rak Area",
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  controller.listData.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: const Center(
                            child: Text(
                              "Belum ada data yang tersedia",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        )
                      : GridView.builder(
                          padding: EdgeInsets.zero,
                          reverse: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.0,
                            crossAxisCount: controller.maxRak,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 6,
                          ),
                          itemCount: controller.listData.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            var item = controller.listData[index];
                            var newTitle = controller
                                .extractDesiredPart(item['head_name']);
                            controller.tambahDataTerisi(
                                quantity: item['quantity']);

                            List transaction = item['transaction'];
                            return InkWell(
                              onTap: () {
                                controller.log.d("ini data log");
                                controller.log.d(data);
                                if (transaction.isEmpty) {
                                  Get.to(InputScansView(
                                    data: {
                                      "head_location_id": controller.idHead
                                    },
                                  ))?.then((value) {
                                    controller.getDataLocation();
                                    controller.terisi = 0;
                                    controller.kosong = 0;
                                  });
                                  debugPrint("empty data");
                                } else {
                                  debugPrint("data berisi");
                                  Get.to(UpdatedScansView(
                                    data: item,
                                  ))?.then((value) {
                                    // controller.terisi = 0;
                                    // controller.kosong = 0;
                                    // controller.getDataLocation();
                                    // controller.refreshAftarBuild();
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: item['quantity'] == 0
                                      ? Colors.grey
                                      : Colors.blue,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey[900]!,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    newTitle,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: baseColor,
            child: const Icon(Icons.add),
            onPressed: () {
              Get.to(InputScansView(
                data: {"head_location_id": controller.idHead},
              ))?.then((value) {
                controller.getDataLocation();
                controller.terisi = 0;
                controller.kosong = 0;
              });
            },
          ),
        );
      },
    );
  }
}
