import 'package:kod_sozluk_mobile/core/constant/uri_constants.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';
import 'package:kod_sozluk_mobile/service/base/entity_service.dart';

class EntryService extends EntityService<Entry> {
  EntryService() : super(path: URLConstants.ENTRY, fromJson: Entry.fromJson);
  final FULL_PATH = "${URLConstants.URL}${URLConstants.ENTRY}";

  Future<bool> addToFavorite(int entryId) async {
    final response = await client.get("$FULL_PATH/$entryId${URLConstants.ADD_TO_FAVORITE}");
    final Map<String, dynamic> responseData = Map<String, dynamic>.from(response.data! as Map);
    return responseData["data"] as bool;
  }
}
