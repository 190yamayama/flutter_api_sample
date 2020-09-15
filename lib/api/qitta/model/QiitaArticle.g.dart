// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QiitaArticle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QiitaArticle _$QiitaArticleFromJson(Map<String, dynamic> json) {
  return QiitaArticle(
    renderedBody: json['rendered_body'] as String,
    body: json['body'] as String,
    coediting: json['coediting'] as bool,
    commentsCount: json['comments_count'] as int,
    createdAt: json['created_at'] as String,
    group: json['group'] as String,
    id: json['id'] as String,
    likesCount: json['likes_count'] as int,
    private: json['private'] as bool,
    reactionsCount: json['reactions_count'] as int,
    tags: (json['tags'] as List)
        ?.map((e) =>
            e == null ? null : QiitaTag.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    title: json['title'] as String,
    updatedAt: json['updated_at'] as String,
    url: json['url'] as String,
    user: json['user'] == null
        ? null
        : QiitaUser.fromJson(json['user'] as Map<String, dynamic>),
    pageViewsCount: json['page_views_count'] as int,
  );
}

Map<String, dynamic> _$QiitaArticleToJson(QiitaArticle instance) =>
    <String, dynamic>{
      'rendered_body': instance.renderedBody,
      'body': instance.body,
      'coediting': instance.coediting,
      'comments_count': instance.commentsCount,
      'created_at': instance.createdAt,
      'group': instance.group,
      'id': instance.id,
      'likes_count': instance.likesCount,
      'private': instance.private,
      'reactions_count': instance.reactionsCount,
      'tags': instance.tags?.map((e) => e?.toJson())?.toList(),
      'title': instance.title,
      'updated_at': instance.updatedAt,
      'url': instance.url,
      'user': instance.user?.toJson(),
      'page_views_count': instance.pageViewsCount,
    };
