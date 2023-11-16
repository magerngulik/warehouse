import 'package:flutter/material.dart';
import '../controller/search_setting_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class SearchSettingView extends StatelessWidget {
  const SearchSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchSettingController>(
      init: SearchSettingController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: const WarehouseAppbar(title: "Search Setting"),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Search By",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          8.0,
                        ),
                      ),
                    ),
                    child: Column(
                      children:
                          List.generate(controller.dataSearch.length, (index) {
                        var item = controller.dataSearch[index];
                        return InkWell(
                          onTap: () {
                            controller.searchField = item;
                            controller.update();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            width: MediaQuery.of(context).size.width * 0.95,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                                color: controller.searchField == item
                                    ? baseColor
                                    : Colors.transparent),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  controller.searchField == "part number"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Set Stock",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text('Normal'),
                                Switch(
                                  value: controller.isMinim,
                                  onChanged: (value) {
                                    controller.isMinim = value;
                                    debugPrint(controller.isMinim.toString());
                                    controller.update();
                                  },
                                ),
                                const Text('Minimum'),
                              ],
                            ),
                          ],
                        )
                      : Container(),
                  const Text(
                    "Sort By",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Descending'),
                      Switch(
                        value: controller.isAcending,
                        onChanged: (value) {
                          controller.isAcending = value;
                          controller.update();
                        },
                      ),
                      const Text('Ascending'),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: baseColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        controller.doSaveSetting();
                      },
                      child: const Text("SIMPAN"),
                    ),
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
