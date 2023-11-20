import 'package:flutter/material.dart';
import '../controller/admin_list_items_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class AdminListItemsView extends StatelessWidget {
  const AdminListItemsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminListItemsController>(
      init: AdminListItemsController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: const WarehouseAppbar(title: "Admin List Part"),
          body: controller.isLOading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : StreamBuilder(
                  stream: WarehouseServices.getStream("part"),
                  builder: (context, snapshot) {
                    if (!snapshot.hasError) {
                      const Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Error"),
                            Text("Cek Koneksi Jaringan Anda")
                          ],
                        ),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.data == null) return Container();
                    final listHeadLocation = snapshot.data;
                    return ListView.builder(
                      itemCount: listHeadLocation!.length,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var item = listHeadLocation[index];
                        return InkWell(
                          onTap: () {
                            Get.to(InputPartsView(
                              item: item,
                            ));
                          },
                          child: Card(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${item['part_name']}",
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      controller.showDialogDelete(item['id']);
                                      // debugPrint("${item['id']}");
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: baseColor,
            child: const Icon(Icons.add),
            onPressed: () {
              Get.to(const InputPartsView());
            },
          ),
        );
      },
    );
  }
}
