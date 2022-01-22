import 'dart:developer';

mixin Logger {
  static void buildLogger(String message) {
    log("[REBUILDING] => $message()");
  }
}
