import 'package:flutter/material.dart';
import '../controller/location_part_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class LocationPartView extends StatelessWidget {
  const LocationPartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationPartController>(
      init: LocationPartController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: const Text(
              "LocationPart",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          body: StreamBuilder(
            stream: controller.getHeadLocation(),
            builder: (context, snapshot) {
              if (!snapshot.hasError) {
                const Center(
                  child: Text("erro"),
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
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "${item['location_name']}",
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
        );
      },
    );
  }
}
