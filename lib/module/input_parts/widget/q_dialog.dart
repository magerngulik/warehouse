import 'package:flutter/material.dart';

class QDialog extends StatelessWidget {
  final String message;
  final Function()? ontap;
  const QDialog({
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
          'Info',
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
        (ontap != null)
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () => ontap!(),
                child: const Text("Ok"),
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"),
              ),
        const SizedBox(
          height: 25.0,
        ),
      ],
    );
  }
}
