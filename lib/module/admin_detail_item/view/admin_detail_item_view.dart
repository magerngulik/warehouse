import 'package:flutter/material.dart';
import '../controller/admin_detail_item_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class AdminDetailItemView extends StatelessWidget {
  const AdminDetailItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminDetailItemController>(
      init: AdminDetailItemController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Detail Item Part View"),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: const Column(
                children: [],
              ),
            ),
          ),
        );
      },
    );
  }
}
