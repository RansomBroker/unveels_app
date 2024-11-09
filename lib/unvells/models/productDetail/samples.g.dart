// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'samples.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Samples _$SamplesFromJson(Map<String, dynamic> json) => Samples(
      json['hasSample'] as bool?,
      json['title'] as String?,
      (json['linkSampleData'] as List<dynamic>?)
          ?.map((e) => LinkedSampleData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SamplesToJson(Samples instance) => <String, dynamic>{
      'hasSample': instance.hasSample,
      'title': instance.title,
      'linkSampleData': instance.linkSampleData,
    };
