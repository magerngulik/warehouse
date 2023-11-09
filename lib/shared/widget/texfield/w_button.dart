import 'package:flutter/material.dart';
import 'package:skripsi_warehouse/shared/color/m_base_color.dart';

class WarehouseButton extends StatelessWidget {
  final Function() ontap;
  final String title;
  const WarehouseButton({
    super.key,
    required this.ontap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 15,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: baseColor),
        onPressed: () => ontap(),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
