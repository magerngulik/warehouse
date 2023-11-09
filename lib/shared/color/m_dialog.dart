import 'package:flutter/material.dart';

class MDialogConfrmationDelete extends StatelessWidget {
  final Function() onTap;

  const MDialogConfrmationDelete({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Konfirmasi'),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Apakah anda yakin ingin menghapus data ini?'),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[600],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("No"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
          ),
          onPressed: () {
            onTap();
            Navigator.pop(context);
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}

class MDialogFailed extends StatelessWidget {
  final String message;

  const MDialogFailed({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Kesalahan'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Terjadi kesalahan: $message'),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[600],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Kembali"),
        ),
      ],
    );
  }
}
