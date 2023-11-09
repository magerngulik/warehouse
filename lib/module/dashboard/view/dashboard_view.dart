import 'package:flutter/material.dart';
import 'package:skripsi_warehouse/shared/color/m_base_color.dart';
import '../controller/dashboard_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: const WarehouseAppbar(title: "e-Warning"),
          drawer: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(controller.username),
                  accountEmail: Text(controller.email ?? ""),
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1600486913747-55e5470d6f40?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
                  ),
                  decoration: BoxDecoration(
                    color: baseColor,
                  ),
                  otherAccountsPictures: const [],
                ),
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text("Password"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.leaderboard_outlined),
                  title: const Text("Job Level "),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.badge),
                  title: const Text("Position"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                  ),
                  title: const Text("Logout"),
                  onTap: () => controller.openDialogLogout(),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: List.generate(controller.menu.length, (index) {
                  var item = controller.menu[index];
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      onTap: () {
                        Get.to(item['onclick']);
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "${item['menu']}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
