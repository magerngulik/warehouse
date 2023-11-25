// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:skripsi_warehouse/core.dart';
import 'package:skripsi_warehouse/module/admin_detail_user/widget/q_my_drop_down_2.dart';
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
                        // QMyDropdown(
                        //   data: const ["admin", "super admin", "user"],
                        //   firstData: controller.roleUserController.text,
                        //   onChanged: (value) {
                        //     controller.roleUserController.text = value;
                        //   },
                        // ),
                        // const Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 12),
                        //   child: Text(
                        //     "Selected Role",
                        //     style: TextStyle(
                        //       fontSize: 18.0,
                        //     ),
                        //   ),
                        // ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "Selected Role",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        QMyDropdown2(
                          data: const ["admin", "super admin", "user"],
                          firstData: controller.roleUserController.text,
                          onChanged: (value) {
                            controller.roleUserController.text = value;
                            debugPrint(value);
                          },
                          title: "Position",
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "Job Level",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        QMyDropdown2(
                          data: const ["Leader", "Member"],
                          firstData: controller.jobLevelController.text,
                          onChanged: (value) {
                            controller.jobLevelController.text = value;
                            debugPrint(value);
                          },
                          title: "Position",
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "Position",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        QMyDropdown2(
                          data: const ["Pulling", "Preperation"],
                          firstData: controller.positionController.text,
                          onChanged: (value) {
                            controller.positionController.text = value;
                            debugPrint(value);
                          },
                          title: "Position",
                        ),
                        const SizedBox(
                          height: 20.0,
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
