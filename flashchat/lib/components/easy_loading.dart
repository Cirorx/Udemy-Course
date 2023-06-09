import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..indicatorColor = Colors.black
    ..textColor = Colors.black
    ..userInteractions = true
    ..dismissOnTap = true;
}

void showLoading(String text) {
  EasyLoading.show(status: text, dismissOnTap: false);
}
