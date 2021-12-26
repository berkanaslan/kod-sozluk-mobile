import 'package:kod_sozluk_mobile/core/constant/uri_constants.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';
import 'package:kod_sozluk_mobile/service/base/entity_service.dart';

class EntryService extends EntityService<Entry> {
  EntryService() : super(path: URLConstants.ENTRY, fromJson: Entry.fromJson);
}
