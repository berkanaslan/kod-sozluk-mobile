import 'package:kod_sozluk_mobile/core/shared_preferences/shared_preferences.dart';
import 'package:kod_sozluk_mobile/model/user.dart';

mixin AppUtil {
  static User? get user => SharedPrefs.getUser();
}
