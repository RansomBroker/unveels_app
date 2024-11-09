// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOrderModel _$PlaceOrderModelFromJson(Map<String, dynamic> json) =>
    PlaceOrderModel(
      email: json['email'] as String?,
      orderId: json['orderId'] as String?,
      incrementId: json['incrementId'] as String?,
      canReorder: json['canReorder'] as bool?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$PlaceOrderModelToJson(PlaceOrderModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'email': instance.email,
      'canReorder': instance.canReorder,
      'orderId': instance.orderId,
      'incrementId': instance.incrementId,
    };

CustomerDetails _$CustomerDetailsFromJson(Map<String, dynamic> json) =>
    CustomerDetails(
      email: json['email'] as String?,
      lastName: json['lastname'] as String?,
      firstName: json['firstname'] as String?,
      groupId: (json['groupId'] as num?)?.toInt(),
      guestCustomer: (json['guestCustomer'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CustomerDetailsToJson(CustomerDetails instance) =>
    <String, dynamic>{
      'email': instance.email,
      'firstname': instance.firstName,
      'groupId': instance.groupId,
      'guestCustomer': instance.guestCustomer,
      'lastname': instance.lastName,
    };
