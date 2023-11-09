import 'package:flutter/material.dart';
import 'package:skripsi_warehouse/shared/color/m_base_color.dart';

class WarehouseTextfield extends StatelessWidget {
  final String hintTitle;
  final TextEditingController controller;
  const WarehouseTextfield({
    super.key,
    required this.hintTitle,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(),
      child: TextFormField(
        // controller: controller.maxLantai,
        controller: controller,
        initialValue: null,
        decoration: InputDecoration(
          filled: true,
          fillColor: textfieldColor,
          hintText: hintTitle,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: textfieldColor)),
        ),
      ),
    );
  }
}
