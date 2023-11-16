import 'package:flutter/material.dart';
import 'package:skripsi_warehouse/core.dart';

class QDialogDelete extends StatelessWidget {
  final String message;
  final Function()? ontap;
  const QDialogDelete({
    super.key,
    required this.message,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: const Center(
        child: Text(
          'Warning',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Tidak"),
        ),
        const SizedBox(
          height: 25.0,
        ),
        (ontap != null)
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => ontap!(),
                child: const Text("Ok"),
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"),
              ),
      ],
    );
  }
}
