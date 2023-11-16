import 'package:flutter/material.dart';

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
