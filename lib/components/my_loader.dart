import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> displayLoader() {
  return EasyLoading.show(
    indicator: const CircularProgressIndicator(
      strokeWidth: 0.8,
    ),
  );
}

Future<void> dismissLoader() {
  return EasyLoading.dismiss();
}
