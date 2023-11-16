import 'package:flutter/material.dart';
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

        controller.log.i(data);

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
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MBoxDescription(
                            title: "All Stock",
                            countItem: controller.allStock.toString(),
                            colors: Colors.green),
                        const SizedBox(
                          width: 20.0,
                        ),
                        MBoxDescription(
                          title: "Status",
                          countItem: controller.minim,
                          colors: (controller.minim == "Minim")
                              ? Colors.red
                              : Colors.black,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 24,
                            offset: Offset(0, 11),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.headName,
                                style: const TextStyle(
                                  fontSize: 24.0,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () => controller.showDialogDelete(),
                                icon: const Icon(
                                  Icons.delete,
                                  size: 24.0,
                                ),
                              ),
                            ],
                          ),
                          QBoxColumn(
                            title: "Part Number",
                            description: controller.partNumber,
                          ),
                          QBoxColumn(
                            title: "Part Name",
                            description: controller.partName,
                          ),
                          QBoxColumn(
                            title: "Location",
                            description: controller.headName,
                          ),
                          QBoxColumn(
                            title: "Quantity",
                            description: controller.quantity.toString(),
                          ),
                          QBoxColumn(
                            title: "Time Stamp",
                            description: controller.updatedAt,
                          ),
                          QBoxColumn(
                            title: "User",
                            description: controller.userChange,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff666666),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(InputScansView(
                                      dataUpdate: data,
                                    ));
                                  },
                                  child: const Text("Update"),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}

class QBoxColumn extends StatelessWidget {
  final String title;
  final String description;
  const QBoxColumn({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
