// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDetailsModel _$AccountDetailsModelFromJson(Map<String, dynamic> json) =>
    AccountDetailsModel(
      accountDetails: (json['accountDetails'] as List<dynamic>?)
          ?.map((e) => AccountDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$AccountDetailsModelToJson(
        AccountDetailsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'accountDetails': instance.accountDetails,
    };

AccountDetails _$AccountDetailsFromJson(Map<String, dynamic> json) =>
    AccountDetails(
      id: (json['id'] as num?)?.toInt(),
      customerName: json['customerName'] as String?,
      customerEmail: json['customerEmail'] as String?,
      acholderName: json['acholderName'] as String?,
      acNumber: json['acNumber'] as String?,
      bankName: json['bankName'] as String?,
      accountHolderName: json['accountHolderName'] as String?,
      bankCode: json['bankCode'] as String?,
      additionalInformation: json['additionalInformation'] as String?,
      requestForDelete: json['requestForDelete'] as bool?,
    );

Map<String, dynamic> _$AccountDetailsToJson(AccountDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerName': instance.customerName,
      'customerEmail': instance.customerEmail,
      'acholderName': instance.acholderName,
      'acNumber': instance.acNumber,
      'bankName': instance.bankName,
      'accountHolderName': instance.accountHolderName,
      'bankCode': instance.bankCode,
      'additionalInformation': instance.additionalInformation,
      'requestForDelete': instance.requestForDelete,
    };
