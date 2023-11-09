import 'package:flutter/material.dart';
import '../controller/login_controller.dart';
import 'package:skripsi_warehouse/core.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: baseColor,
            title: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_2_outlined,
                  size: 32.0,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 160.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/icons/logo.png",
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        16.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                QTextFieldLogin(
                    icon: Icons.person, txtController: controller.textEmail),
                const SizedBox(
                  height: 30.0,
                ),
                QTextFieldLogin(
                    icon: Icons.lock,
                    txtController: controller.textPassword,
                    isPassword: true),
                const SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          controller.doLogin();
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => controller.exitApp(),
                        child: const Text(
                          "Cencel",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class QTextFieldLogin extends StatelessWidget {
  final IconData icon;
  final TextEditingController txtController;
  final bool? isPassword;
  final String? initialValue;
  const QTextFieldLogin({
    super.key,
    required this.icon,
    required this.txtController,
    this.isPassword,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 50.0,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: TextFormField(
            initialValue: initialValue,
            controller: txtController,
            style: const TextStyle(color: Colors.black),
            obscureText: isPassword ?? false,
            decoration: InputDecoration(
              labelStyle: const TextStyle(color: Colors.black),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(color: Colors.green, width: 5),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(color: Colors.green, width: 5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(color: Colors.green, width: 5),
              ),
            ),
            onChanged: (value) {},
          ),
        )
      ],
    );
  }
}
