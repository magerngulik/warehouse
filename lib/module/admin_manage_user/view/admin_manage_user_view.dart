import 'package:flutter/material.dart';
import '../controller/admin_manage_user_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class AdminManageUserView extends StatelessWidget {
  const AdminManageUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminManageUserController>(
      init: AdminManageUserController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: const WarehouseAppbar(title: "Admin Manage User"),
          body: controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount:
                      controller.user.isEmpty ? 1 : controller.user.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (controller.user.isEmpty) {
                      return const Center(
                        child: Text("Belum ada data yang tersedia"),
                      );
                    }

                    var item = controller.user[index];

                    return InkWell(
                      onTap: () {
                        Get.to(AdminDetailUserView(
                          data: item,
                        ));
                      },
                      child: Card(
                        child: ListTile(
                          title: Text("${item['username']}"),
                          subtitle: Text("${item['email']}"),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
