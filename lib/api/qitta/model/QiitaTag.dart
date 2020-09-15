import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'QiitaTag.g.dart';

@JsonSerializable()
class QiitaTag {
  String name;
  List<dynamic> versions;

  QiitaTag({
    this.name,
    this.versions,
  });

  // ↓　ここは.g.dartを自動生成してから追記
  // （注意）先に書いておいてもエラーとなりg.dartが生成されないことがある？
  factory QiitaTag.fromJson(Map<String, dynamic> json) => _$QiitaTagFromJson(json);
  Map<String, dynamic> toJson() => _$QiitaTagToJson(this);

  @override
  String toString() => json.encode(toJson());
  // ↑　ここは.g.dartを自動生成してから追記

}