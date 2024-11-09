// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionValue _$OptionValueFromJson(Map<String, dynamic> json) => OptionValue(
      json['title'] as String?,
      json['isQtyUserDefined'] as String?,
      json['isDefault'] as String?,
      json['optionId'] as String?,
      json['optionValueId'] as String?,
      json['foramtedPrice'] as String?,
      (json['price'] as num?)?.toDouble(),
      json['isSingle'] as bool?,
      json['defaultQty'] as String?,
    );

Map<String, dynamic> _$OptionValueToJson(OptionValue instance) =>
    <String, dynamic>{
      'title': instance.title,
      'isQtyUserDefined': instance.isQtyUserDefined,
      'isDefault': instance.isDefault,
      'optionId': instance.optionId,
      'optionValueId': instance.optionValueId,
      'foramtedPrice': instance.foramtedPrice,
      'price': instance.price,
      'isSingle': instance.isSingle,
      'defaultQty': instance.defaultQty,
    };
