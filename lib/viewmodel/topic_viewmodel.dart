import 'package:kod_sozluk_mobile/core/locator.dart';
import 'package:kod_sozluk_mobile/model/base/page.dart';
import 'package:kod_sozluk_mobile/model/topic.dart';
import 'package:kod_sozluk_mobile/service/topic_service.dart';
import 'package:kod_sozluk_mobile/viewmodel/base/base_viewmodel.dart';
import 'package:kod_sozluk_mobile/viewmodel/base/i_base_viewmodel.dart';

class TopicViewModel extends BaseViewModel<Topic> {
  TopicViewModel() : super(const InitialState(), locator<TopicService>());

  List<Topic> topics = [];

  int _pageNumber = 0;
  int? _totalPages;

  Future<void> getPagedTopics() async {
    if (isLoading) return;

    if (_totalPages == null || _pageNumber < _totalPages!) {
      Page<Topic>? pagedTopic = await getPaged();

      if (pagedTopic != null) {
        topics.addAll(pagedTopic.content!);

        _pageNumber++;
        _totalPages = (pagedTopic.totalPages! - 1);
      }
    }
  }

  Future<void> refresh() async {
    clean();
    await getPagedTopics();
  }

  clean() {
    topics.clear();
    _pageNumber = 0;
    _totalPages = null;
  }
}
