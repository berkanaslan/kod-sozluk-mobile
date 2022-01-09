import 'package:kod_sozluk_mobile/core/constant/app_constants.dart';
import 'package:kod_sozluk_mobile/core/locator.dart';
import 'package:kod_sozluk_mobile/model/base/page.dart';
import 'package:kod_sozluk_mobile/model/topic.dart';
import 'package:kod_sozluk_mobile/service/topic_service.dart';
import 'package:kod_sozluk_mobile/viewmodel/base/base_viewmodel.dart';
import 'package:kod_sozluk_mobile/viewmodel/base/i_base_viewmodel.dart';

class TopicViewModel extends BaseViewModel<Topic> {
  TopicViewModel() : super(const InitialState(), locator<TopicService>());

  // -------------------------------------------------------------------------------------------------------------------
  // LATEST TOPICS                                                                                                     /
  // /topic/today                                                                                                      /
  // -------------------------------------------------------------------------------------------------------------------
  List<Topic> latestTopics = [];

  int _latestTopicPageNumber = 0;
  int? _latestTopicTotalPages;

  Future<void> getPagedLatestTopics() async {
    if (isLoading) return;

    if (_latestTopicTotalPages == null || _latestTopicPageNumber < _latestTopicTotalPages!) {
      Page<Topic>? response = await getPaged(pn: _latestTopicPageNumber, sb: "id", sd: AppConstants.SORT_DESC);

      if (response != null) {
        latestTopics.addAll(response.content!);

        _latestTopicPageNumber++;
        _latestTopicTotalPages = (response.totalPages! - 1);
      }
    }
  }

  Future<void> refreshLatestTopics() async {
    clearLatestTopics();
    await getPagedLatestTopics();
  }

  clearLatestTopics() {
    latestTopics.clear();
    _latestTopicPageNumber = 0;
    _latestTopicTotalPages = null;
  }

  // -------------------------------------------------------------------------------------------------------------------
  // LATEST TOPICS                                                                                                     /
  // /topic/today                                                                                                      /
  // -------------------------------------------------------------------------------------------------------------------
  List<Topic> trendTopics = [];

  int _trendTopicPageNumber = 0;
  int? _trendTopicTotalPages;

  Future<void> getPagedTrendTopics() async {
    if (isLoading) return;

    if (_trendTopicTotalPages == null || _trendTopicPageNumber < _trendTopicTotalPages!) {
      Page<Topic>? response = await getPaged(additionalPath: "/trend", pn: _trendTopicPageNumber);

      if (response != null) {
        trendTopics.addAll(response.content!);

        _trendTopicPageNumber++;
        _trendTopicTotalPages = (response.totalPages! - 1);
      }
    }
  }

  Future<void> refreshTrendTopics() async {
    clearLatestTopics();
    await getPagedLatestTopics();
  }

  clearTrendTopics() {
    trendTopics.clear();
    _trendTopicPageNumber = 0;
    _trendTopicTotalPages = null;
  }
}
