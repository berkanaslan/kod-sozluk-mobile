import 'package:kod_sozluk_mobile/core/constant/uri_constants.dart';
import 'package:kod_sozluk_mobile/model/head.dart';
import 'package:kod_sozluk_mobile/service/base/entity_service.dart';

class HeadService extends EntityService<Head> {
  HeadService() : super(path: URLConstants.HEAD, fromJson: Head.fromJson);
}
