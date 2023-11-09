import 'package:flutter/material.dart';
import 'package:skripsi_warehouse/module/testing/widget/q_dropdown.dart';
import '../controller/testing_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class TestingView extends StatelessWidget {
  const TestingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TestingController>(
      init: TestingController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
            appBar: AppBar(
              title: const Text("Testing"),
            ),
            body: const Center(
              child: Text(
                "Under Testing",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ));
      },
    );
  }
}
