// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'website_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebsiteData _$WebsiteDataFromJson(Map<String, dynamic> json) => WebsiteData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      baseUrl: json['baseUrl'] as String?,
      selected: json['selected'] as bool?,
    );

Map<String, dynamic> _$WebsiteDataToJson(WebsiteData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'baseUrl': instance.baseUrl,
      'selected': instance.selected,
    };
