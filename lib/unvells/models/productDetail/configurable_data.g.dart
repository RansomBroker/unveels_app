// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configurable_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurableData _$ConfigurableDataFromJson(Map<String, dynamic> json) =>
    ConfigurableData(
      (json['attributes'] as List<dynamic>?)
          ?.map((e) => Attributes.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['template'] as String?,
      (json['optionPrices'] as List<dynamic>?)
          ?.map((e) => OptionPrices.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['prices'] == null
          ? null
          : Prices.fromJson(json['prices'] as Map<String, dynamic>),
      json['id'] as String?,
      json['chooseText'] as String?,
      json['images'] as String?,
      json['index'] as String?,
      json['swatchData'] as String?,
    );

Map<String, dynamic> _$ConfigurableDataToJson(ConfigurableData instance) =>
    <String, dynamic>{
      'attributes': instance.attributes,
      'template': instance.template,
      'optionPrices': instance.optionPrices,
      'prices': instance.prices,
      'id': instance.id,
      'chooseText': instance.chooseText,
      'images': instance.images,
      'index': instance.index,
      'swatchData': instance.swatchData,
    };
