import 'package:kod_sozluk_mobile/core/constant/app_constants.dart';
import 'package:kod_sozluk_mobile/core/constant/uri_constants.dart';
import 'package:kod_sozluk_mobile/core/locator.dart';
import 'package:kod_sozluk_mobile/model/base/page.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';
import 'package:kod_sozluk_mobile/service/entry_service.dart';
import 'package:kod_sozluk_mobile/viewmodel/base/base_viewmodel.dart';
import 'package:kod_sozluk_mobile/viewmodel/base/i_base_viewmodel.dart';

class EntryViewModel extends BaseViewModel<Entry> {
  EntryViewModel() : super(const InitialState(), locator<EntryService>());

  List<Entry> entries = [];

  int _pageNumber = 0;
  int? _totalPages;

  Future<void> getPagedEntriesByTopicId(final int topicId) async {
    if (isLoading) return;

    if (_totalPages == null || _pageNumber < _totalPages!) {
      Page<Entry>? pagedEntry = await getPaged(
        pn: _pageNumber,
        sd: AppConstants.SORT_DESC,
        requestParams: "${URLConstants.TOPIC}/$topicId",
      );

      if (pagedEntry != null) {
        entries.addAll(pagedEntry.content!);

        _pageNumber++;
        _totalPages = pagedEntry.totalPages;
      }
    }
  }

  clear() {
    entries.clear();
    _pageNumber = 0;
    _totalPages = null;
  }
}
