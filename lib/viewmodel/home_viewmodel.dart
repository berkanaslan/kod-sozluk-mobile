import 'package:kod_sozluk_mobile/core/constant/uri_constants.dart';
import 'package:kod_sozluk_mobile/core/locator.dart';
import 'package:kod_sozluk_mobile/model/head.dart';
import 'package:kod_sozluk_mobile/service/head_service.dart';
import 'package:kod_sozluk_mobile/viewmodel/base/base_viewmodel.dart';
import 'package:kod_sozluk_mobile/viewmodel/base/i_base_viewmodel.dart';

class HomeViewModel extends BaseViewModel<Head> {
  HomeViewModel() : super(const InitialState(), locator<HeadService>());

  List<Head> heads = [];

  Future<void> getAllHeads() async {
    if (this.heads.isNotEmpty) return;

    List<Head>? heads = await getAll(requestParams: URLConstants.ALL);
    if (heads != null) this.heads.addAll(heads);
  }
}
