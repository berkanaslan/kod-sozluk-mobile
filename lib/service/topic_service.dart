import 'package:kod_sozluk_mobile/core/constant/uri_constants.dart';
import 'package:kod_sozluk_mobile/model/topic.dart';
import 'package:kod_sozluk_mobile/service/base/entity_service.dart';

class TopicService extends EntityService<Topic> {
  TopicService() : super(path: URLConstants.TOPIC, fromJson: Topic.fromJson);
}
