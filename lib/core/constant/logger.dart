import 'package:flutter/material.dart';

mixin Logger {
  static void buildLogger(String message) {
    debugPrint("\x1B[31mREBUILDING => $message()\x1B[0m");
  }
}
