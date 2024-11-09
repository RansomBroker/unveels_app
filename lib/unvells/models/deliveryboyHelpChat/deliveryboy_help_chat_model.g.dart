// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deliveryboy_help_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryboyHelpChatModel _$DeliveryboyHelpChatModelFromJson(
        Map<String, dynamic> json) =>
    DeliveryboyHelpChatModel(
      sellerList: (json['sellerList'] as List<dynamic>?)
          ?.map((e) => SellerListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      apiKey: json['apiKey'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$DeliveryboyHelpChatModelToJson(
        DeliveryboyHelpChatModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'apiKey': instance.apiKey,
      'sellerList': instance.sellerList,
    };

SellerListData _$SellerListDataFromJson(Map<String, dynamic> json) =>
    SellerListData(
      name: json['name'] as String?,
      customerId: (json['customerId'] as num?)?.toInt(),
      customerToken: json['customerToken'] as String?,
      profileImage: json['profileImage'] as String?,
      token: json['token'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$SellerListDataToJson(SellerListData instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'customerToken': instance.customerToken,
      'token': instance.token,
      'name': instance.name,
      'email': instance.email,
      'profileImage': instance.profileImage,
    };
