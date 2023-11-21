import 'package:flutter/material.dart';
import 'package:skripsi_warehouse/shared/color/m_base_color.dart';

class QtextfieldSimple extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool? readOnly;
  const QtextfieldSimple({
    Key? key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: const EdgeInsets.only(),
          child: TextFormField(
            initialValue: null,
            readOnly: readOnly ?? false,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: textfieldColor,
              hintText: hintText,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: textfieldColor)),
            ),
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
