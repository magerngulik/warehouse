import 'package:flutter/material.dart';
import '../controller/admin_menu_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class AdminMenuView extends StatelessWidget {
  const AdminMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminMenuController>(
      init: AdminMenuController(),
      builder: (controller) {
        controller.view = this;
        return Scaffold(
          appBar: WarehouseAppbar(title: "Menu Admin Panel", actions: [
            IconButton(
              onPressed: () => controller.openDialogLogout(),
              icon: const Icon(
                Icons.logout,
                size: 24.0,
              ),
            )
          ]),
          body: GridView.builder(
            padding: const EdgeInsets.all(15.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.0,
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemCount: controller.halaman.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var item = controller.halaman[index];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => item['ontap'] as Widget),
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              item["image"],
                            ),
                            fit: BoxFit.fitHeight,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              8.0,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        item['title'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
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
