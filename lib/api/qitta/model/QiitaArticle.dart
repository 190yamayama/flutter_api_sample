import 'dart:convert';

import 'package:flutter_api_sample/util/Util.dart';
import 'package:json_annotation/json_annotation.dart';
import 'QiitaTag.dart';
import 'QiitaUser.dart';

part 'QiitaArticle.g.dart';

@JsonSerializable(explicitToJson: true)
class QiitaArticle {
  @JsonKey(name: 'rendered_body')
  String renderedBody;
  String body;
  bool coediting;
  @JsonKey(name: 'comments_count')
  int commentsCount;
  @JsonKey(name: 'created_at')
  String createdAt;
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
  String updatedAt;
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
  // （注意）先に書いておいてもエラーとなりg.dartが生成されない
  factory QiitaArticle.fromJson(Map<String, dynamic> json) => _$QiitaArticleFromJson(json);
  Map<String, dynamic> toJson() => _$QiitaArticleToJson(this);

  @override
  String toString() => json.encode(toJson());

  get createdAtString {
    if (createdAt == null)
      return "";
    return Util().dateTimeString(createdAt, Util.ymd, Util.localJp);
  }

  get updatedAtString {
    if (updatedAt == null)
      return "";
    return Util().dateTimeString(updatedAt, Util.ymd, Util.localJp);
  }

  get likesCountString {
    if (likesCount == null || likesCount == 0)
      return "-";
    return "$likesCount";
  }
  // ↑　ここは.g.dartを自動生成してから追記

}


