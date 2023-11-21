// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/module/admin_detail_user/widget/q_textfield_simple.dart';

import '../controller/admin_detail_user_controller.dart';

class AdminDetailUserView extends StatelessWidget {
  final Map data;
  const AdminDetailUserView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminDetailUserController>(
      init: AdminDetailUserController(data),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: const WarehouseAppbar(title: "Admin Detail User"),
          body: SingleChildScrollView(
            child: controller.isLoading
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QtextfieldSimple(
                            controller: controller.emailController,
                            hintText: "Email",
                            title: "Email",
                            readOnly: true),
                        QtextfieldSimple(
                          controller: controller.usernameController,
                          hintText: "Username",
                          title: "Username",
                        ),
                        QMyDropdown(
                          data: const ["admin", "super admin", "user"],
                          firstData: controller.roleUserController.text,
                          onChanged: (value) {
                            controller.roleUserController.text = value;
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: baseColor,
                            ),
                            onPressed: () => controller.doCheckValidation(),
                            child: const Text("Simpan"),
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
