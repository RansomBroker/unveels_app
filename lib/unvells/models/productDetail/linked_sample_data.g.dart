// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linked_sample_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkedSampleData _$LinkedSampleDataFromJson(Map<String, dynamic> json) =>
    LinkedSampleData(
      json['sampleTitle'] as String?,
      json['url'] as String?,
      json['fileName'] as String?,
      json['mimeType'] as String?,
    );

Map<String, dynamic> _$LinkedSampleDataToJson(LinkedSampleData instance) =>
    <String, dynamic>{
      'sampleTitle': instance.sampleTitle,
      'url': instance.url,
      'fileName': instance.fileName,
      'mimeType': instance.mimeType,
    };
