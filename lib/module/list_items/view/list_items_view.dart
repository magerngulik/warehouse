import 'package:flutter/material.dart';
import '../controller/list_items_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class ListItemsView extends StatelessWidget {
  const ListItemsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListItemsController>(
      init: ListItemsController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("ListItems"),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: const [],
              ),
            ),
          ),
        );
      },
    );
  }
}
