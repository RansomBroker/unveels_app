// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadProduct _$DownloadProductFromJson(Map<String, dynamic> json) =>
    DownloadProduct(
      mimeType: json['mimeType'] as String?,
      url: json['url'] as String?,
      fileName: json['fileName'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$DownloadProductToJson(DownloadProduct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'mimeType': instance.mimeType,
      'url': instance.url,
      'fileName': instance.fileName,
    };
