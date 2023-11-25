import 'package:flutter/material.dart';
import 'package:skripsi_warehouse/module/admin_detail_user/widget/q_my_drop_down_2.dart';
import '../controller/register_user_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class RegisterUserView extends StatelessWidget {
  const RegisterUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterUserController>(
      init: RegisterUserController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: const WarehouseAppbar(title: "Register User"),
          body: controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WarehouseTextfield(
                          hintTitle: "Username",
                          controller: controller.nameController,
                        ),
                        WarehouseTextfield(
                          hintTitle: "Email",
                          controller: controller.emailController,
                        ),
                        WarehouseTextfield(
                          hintTitle: "Password",
                          controller: controller.passwordController,
                        ),
                        WarehouseTextfield(
                          hintTitle: "Confirm Password",
                          controller: controller.confirmPsController,
                        ),
                        QMyDropdown2(
                          data: const ["Leader", "Member"],
                          onChanged: (value) {
                            controller.jobLevel.text = value;
                            debugPrint(value);
                          },
                          title: "Job Level",
                          hintText: "Job Level",
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        QMyDropdown2(
                          data: const ["Pulling", "Preperation"],
                          onChanged: (value) {
                            controller.positon.text = value;
                            debugPrint(value);
                          },
                          title: "Position",
                          hintText: "Position",
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        WarehouseButton(
                            ontap: () => controller.doRegister(),
                            title: "Register"),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
