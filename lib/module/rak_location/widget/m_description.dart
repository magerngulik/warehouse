import 'package:flutter/material.dart';

class MBoxDescription extends StatelessWidget {
  final String title;
  final String countItem;
  final Color colors;
  const MBoxDescription({
    Key? key,
    required this.title,
    required this.countItem,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            8.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 24,
            offset: Offset(0, 11),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            countItem,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: colors,
            ),
          ),
        ],
      ),
    );
  }
}
