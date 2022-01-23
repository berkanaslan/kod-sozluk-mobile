import 'package:kod_sozluk_mobile/core/constant/app_constants.dart';
import 'package:kod_sozluk_mobile/core/locator.dart';
import 'package:kod_sozluk_mobile/model/base/page.dart';
import 'package:kod_sozluk_mobile/model/topic.dart';
import 'package:kod_sozluk_mobile/repository/base/base_entity_state.dart';
import 'package:kod_sozluk_mobile/repository/base/base_repository.dart';
import 'package:kod_sozluk_mobile/service/topic_service.dart';

class TopicRepository extends BaseRepository<Topic> {
  TopicRepository() : super(const InitialState(), locator<TopicService>());

  Future<Page<Topic>?> getLatestTopics({required int pageNumber, int? totalPages}) async {
    if (totalPages == null || pageNumber < totalPages) {
      return await getPaged(pn: pageNumber, sb: "id", sd: AppConstants.SORT_DESC);
    }
  }

  Future<Page<Topic>?> getTrendTopics({required int pageNumber, int? totalPages}) async {
    if (totalPages == null || pageNumber < totalPages) {
      return await getPaged(additionalPath: "/trend", pn: pageNumber);
    }
  }

  void clear() {}
}
