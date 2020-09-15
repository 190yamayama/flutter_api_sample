// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QiitaTag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QiitaTag _$QiitaTagFromJson(Map<String, dynamic> json) {
  return QiitaTag(
    name: json['name'] as String,
    versions: json['versions'] as List,
  );
}

Map<String, dynamic> _$QiitaTagToJson(QiitaTag instance) => <String, dynamic>{
      'name': instance.name,
      'versions': instance.versions,
    };
