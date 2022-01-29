import 'package:kod_sozluk_mobile/core/constant/app_constants.dart';
import 'package:kod_sozluk_mobile/core/constant/uri_constants.dart';
import 'package:kod_sozluk_mobile/core/locator.dart';
import 'package:kod_sozluk_mobile/model/base/page.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';
import 'package:kod_sozluk_mobile/repository/base/base_entity_state.dart';
import 'package:kod_sozluk_mobile/repository/base/base_repository.dart';
import 'package:kod_sozluk_mobile/service/entry_service.dart';

class EntryRepository extends BaseRepository<Entry> {
  EntryRepository() : super(const InitialState(), locator<EntryService>());

  Future<Page<Entry>?> getEntriesByTopicId({required int topicId, required int pageNumber, int? totalPages}) async {
    if (isLoading) return null;

    if (totalPages == null || pageNumber < totalPages) {
      return await getPaged(
        pn: pageNumber,
        sd: AppConstants.SORT_ASC,
        additionalPath: "${URLConstants.TOPIC}/$topicId",
      );
    }
  }

  Future<Page<Entry>?> getEntriesOfUser({required int userId, required int pageNumber, int? totalPages}) async {
    if (isLoading) return null;

    if (totalPages == null || pageNumber < totalPages) {
      return await getPaged(
        pn: pageNumber,
        sd: AppConstants.SORT_DESC,
        additionalPath: "${URLConstants.USER}/$userId",
      );
    }
  }

  Future<Page<Entry>?> getFavoritedEntriesOfUser(
      {required int userId, required int pageNumber, int? totalPages}) async {
    if (isLoading) return null;

    if (totalPages == null || pageNumber < totalPages) {
      return await getPaged(
        pn: pageNumber,
        sd: AppConstants.SORT_DESC,
        additionalPath: "${URLConstants.USER}/$userId${URLConstants.FAVORITES}",
      );
    }
  }

  Future<bool> addToFavorite({required int entryId}) async {
    return await locator<EntryService>().addToFavorite(entryId);
  }
}
