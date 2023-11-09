import 'package:flutter/material.dart';

class QDialongNoEmpty extends StatelessWidget {
  final String title;
  const QDialongNoEmpty({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Kesalahan',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              'Data $title tidak boleh kosong',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Kembali",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
