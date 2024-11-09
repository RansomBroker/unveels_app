// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'links.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      json['title'] as String?,
      json['linksPurchasedSeparately'] as bool?,
      (json['linkData'] as List<dynamic>?)
          ?.map((e) => LinkData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'title': instance.title,
      'linksPurchasedSeparately': instance.linksPurchasedSeparately,
      'linkData': instance.linkData,
    };
