import 'package:flutter/material.dart';

class QLoadingWidget extends StatelessWidget {
  const QLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
