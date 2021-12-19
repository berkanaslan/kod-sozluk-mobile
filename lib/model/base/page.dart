import 'package:kod_sozluk_mobile/model/base/serializable.dart';

class Page<T extends Serializable> implements Serializable {
  List<T>? content;
  int? totalElements;
  int? totalPages;
  bool? first;
  bool? last;
  int? size;
  int? numberOfElements;
  bool? empty;

  Page({this.content, this.totalElements, this.totalPages, this.first, this.last, this.size, this.numberOfElements, this.empty});

  static Page<T> fromJson<T extends Serializable>(Map<String, dynamic> json) {
    final Page<T> page = Page();
    page.totalElements = json["totalElements"] as int;
    page.totalPages = json["totalPages"] as int;
    page.first = json["first"] as bool;
    page.last = json["last"] as bool;
    page.size = json["size"] as int;
    page.empty = json["empty"] as bool;
    return page;
  }

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  @override
  String toString() {
    return 'Page{content: $content, totalElements: $totalElements, totalPages: $totalPages, first: $first, last: $last, size: $size, numberOfElements: $numberOfElements, empty: $empty}';
  }
}
