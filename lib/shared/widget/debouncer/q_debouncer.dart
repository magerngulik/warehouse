import 'dart:async';

import 'package:flutter/material.dart';

class SimagerDebouncer {
  final Duration duration;
  SimagerDebouncer(this.duration);

  Timer? _timer;

  void run(VoidCallback action) {
    bool isActive = _timer?.isActive ?? false;
    if (isActive) {
      _timer?.cancel();
    }
    _timer = Timer(duration, action);
  }
}
