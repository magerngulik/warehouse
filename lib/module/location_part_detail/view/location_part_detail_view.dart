import 'package:flutter/material.dart';
import 'package:skripsi_warehouse/shared/services/warehouse_services.dart';
import '../controller/location_part_detail_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class LocationPartDetailView extends StatelessWidget {
  final Map dataHead;
  const LocationPartDetailView({Key? key, required this.dataHead})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationPartDetailController>(
      init: LocationPartDetailController(data: dataHead),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              "Location Detail ${dataHead['location_name']}",
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: StreamBuilder(
            stream: WarehouseServices.getStreamById(
                column: "head_location_id",
                tblName: "location",
                id: dataHead['id']),
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

              if (snapshot.data == null) {
                return const Center(
                  child: Text(
                    "Belum ada data yang tersedia",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                );
              }
              final listHeadLocation = snapshot.data;
              return ListView.builder(
                itemCount: listHeadLocation!.length,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var item = listHeadLocation[index];
                  if (listHeadLocation.isEmpty) {
                    return const Center(
                      child: Text(
                        "Belum ada data yang tersedia",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    );
                  }

                  debugPrint("item: $item");
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (detail) {},
                    confirmDismiss: (direction) async {
                      bool confirm = false;
                      await showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm'),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                      'Are you sure you want to delete this item?'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[600],
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("No"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey,
                                ),
                                onPressed: () {
                                  confirm = true;
                                  controller.deleteData(item['id']);
                                  Navigator.pop(context);
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );
                      if (confirm) {
                        return Future.value(true);
                      }
                      return Future.value(false);
                    },
                    child: InkWell(
                      onTap: () {
                        debugPrint("Data item: $item");
                        debugPrint("data quantity 1:${item['quantity']} ");
                        debugPrint("data quantity 1:${item['quantity']} ");
                        Get.to(AddLocationPartView(
                          data: dataHead,
                          id: item['id'],
                          quatity: item['quantity'],
                        ))?.then((value) => controller.update());
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "${item['head_name']}",
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
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
            child: const Icon(
              Icons.add,
            ),
            onPressed: () {
              Get.to(AddLocationPartView(
                data: dataHead,
              ))?.then((value) => controller.update());
            },
          ),
        );
      },
    );
  }
}
