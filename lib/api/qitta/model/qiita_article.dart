import 'dart:convert';

import 'package:flutter_api_sample/api/converter/custom_date_time_converter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'qiita_tag.dart';
import 'qiita_user.dart';

part 'qiita_article.g.dart';

@CustomDateTimeConverter()
@JsonSerializable(explicitToJson: true)
class QiitaArticle {
  @JsonKey(name: 'rendered_body')
  String renderedBody;
  String body;
  bool coediting;
  @JsonKey(name: 'comments_count')
  int commentsCount;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  String group;
  String id;
  @JsonKey(name: 'likes_count')
  int likesCount;
  bool private;
  @JsonKey(name: 'reactions_count')
  int reactionsCount;
  List<QiitaTag> tags;
  String title;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  String url;
  QiitaUser user;
  @JsonKey(name: 'page_views_count')
  int pageViewsCount;

  QiitaArticle({
    this.renderedBody,
    this.body,
    this.coediting,
    this.commentsCount,
    this.createdAt,
    this.group,
    this.id,
    this.likesCount,
    this.private,
    this.reactionsCount,
    this.tags,
    this.title,
    this.updatedAt,
    this.url,
    this.user,
    this.pageViewsCount,
  });

  // ↓　ここは.g.dartを自動生成してから追記。
  //（注意）先に書いておいてもエラーとなりg.dartが生成されないことがある？
  factory QiitaArticle.fromJson(Map<String, dynamic> json) => _$QiitaArticleFromJson(json);
  Map<String, dynamic> toJson() => _$QiitaArticleToJson(this);

  @override
  String toString() => json.encode(toJson());

  static final String ymd = "yyyy/MM/dd(E) HH:mm";
  static final String localJp = "ja_JP";

  get createdAtString {
    if (createdAt == null)
      return "";
    return createdAt.parseString(ymd, localJp);
  }

  get updatedAtString {
    if (updatedAt == null)
      return "";
    return updatedAt.parseString(ymd, localJp);
  }

  get likesCountString {
    if (likesCount == null || likesCount == 0)
      return "-";
    return "$likesCount";
  }
  // ↑　ここは.g.dartを自動生成してから追記

}

extension DateTimeExtension on DateTime {

  String parseString(String formatterString, String local) {
    initializeDateFormatting(local);

    if (this == null)
      return "";
    var formatter = new DateFormat(formatterString, local);
    var formatted = formatter.format(this); // DateからString
    return formatted;
  }

}