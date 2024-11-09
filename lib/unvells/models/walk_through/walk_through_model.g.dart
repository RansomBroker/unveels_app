// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walk_through_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalkThroughModel _$WalkThroughModelFromJson(Map<String, dynamic> json) =>
    WalkThroughModel(
      walkthroughVersion: (json['walkthroughVersion'] as num?)?.toDouble(),
      walkthroughData: (json['walkthroughData'] as List<dynamic>?)
          ?.map((e) => WalkthroughData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$WalkThroughModelToJson(WalkThroughModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'walkthroughVersion': instance.walkthroughVersion,
      'walkthroughData': instance.walkthroughData,
    };

WalkthroughData _$WalkthroughDataFromJson(Map<String, dynamic> json) =>
    WalkthroughData(
      json['id'] as String?,
      json['image'] as String?,
      json['title'] as String?,
      json['content'] as String?,
    );

Map<String, dynamic> _$WalkthroughDataToJson(WalkthroughData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.name,
      'title': instance.productId,
      'content': instance.content,
    };
