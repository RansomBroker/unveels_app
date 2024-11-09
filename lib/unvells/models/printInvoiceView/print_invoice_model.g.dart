// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrintInvoiceModel _$PrintInvoiceModelFromJson(Map<String, dynamic> json) =>
    PrintInvoiceModel(
      url: json['url'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$PrintInvoiceModelToJson(PrintInvoiceModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'url': instance.url,
    };
