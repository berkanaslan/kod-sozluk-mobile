import 'package:get_it/get_it.dart';
import 'package:kod_sozluk_mobile/service/auth_service.dart';
import 'package:kod_sozluk_mobile/service/entry_service.dart';
import 'package:kod_sozluk_mobile/service/topic_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => TopicService());
  locator.registerLazySingleton(() => EntryService());
  locator.registerLazySingleton(() => LoginService());
  locator.registerLazySingleton(() => UserService());
}
