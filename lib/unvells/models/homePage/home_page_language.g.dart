// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageData _$LanguageDataFromJson(Map<String, dynamic> json) => LanguageData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      stores: (json['stores'] as List<dynamic>?)
          ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$LanguageDataToJson(LanguageData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'id': instance.id,
      'name': instance.name,
      'stores': instance.stores,
    };
