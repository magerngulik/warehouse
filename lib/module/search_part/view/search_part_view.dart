import 'package:flutter/material.dart';
import '../controller/search_part_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class SearchPartView extends StatelessWidget {
  const SearchPartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchPartController>(
      init: SearchPartController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(),
              child: TextFormField(
                controller: controller.textSearch,
                decoration: const InputDecoration(
                  hintText: "Search Here",
                  border: InputBorder.none,
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  disabledBorder: InputBorder.none,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                onChanged: (value) {
                  controller.serchData();
                },
                onSaved: (newValue) {},
              ),
            ),
            actions: const [],
          ),
          body: controller.isLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const CircularProgressIndicator(),
                )
              : !controller.partFilters
                  ? Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: controller.dataLocation.isEmpty
                            ? 1
                            : controller.dataLocation.length,
                        physics: const ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          if (controller.dataLocation.isEmpty) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: const Center(
                                child: Text(
                                  "Belum ada data yang tersedia",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            var items = controller.dataLocation[index];

                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: InkWell(
                                onTap: () {
                                  Get.to(InputScansView(
                                    dataSearch: items,
                                  ));
                                  controller.log.i(items);
                                },
                                child: Card(
                                  color: Colors.white,
                                  elevation: 2,
                                  child: ListTile(
                                    title: Text("${items['head_name']}"),
                                    // subtitle: Text(result['head_name']),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    )
                  : Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: controller.dataPart.isEmpty
                            ? 1
                            : controller.dataPart.length,
                        physics: const ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          if (controller.dataPart.isEmpty) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: const Center(
                                child: Text(
                                  "Belum ada data yang tersedia",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            var items = controller.dataPart[index];
                            var result = items['result_json'];
                            var transaction = result['transaction'][0];
                            controller.log.e(result);
                            var part = transaction['part'];

                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: InkWell(
                                onTap: () => Get.to(UpdatedScansView(
                                  data: result,
                                )),
                                child: Card(
                                  color: Colors.white,
                                  elevation: 2,
                                  child: ListTile(
                                    title: Text("${part['part_name']}"),
                                    subtitle: Text(result['head_name']),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
        );
      },
    );
  }
}
