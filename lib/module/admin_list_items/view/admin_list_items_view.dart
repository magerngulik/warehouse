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
          body: StreamBuilder(
            stream: WarehouseServices.getStream("part"),
            builder: (context, snapshot) {
              if (!snapshot.hasError) {
                const Center(
                  child: Text("error"),
                );
              }

              if (!snapshot.hasData) {
                const Center(
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
                      Get.to(LocationPartDetailView(
                        dataHead: item,
                      ));
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "${item['part_name']}",
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
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
