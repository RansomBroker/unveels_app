// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    UserDataModel(
      email: json['email'] as String?,
      name: json['name'] as String?,
      bannerImage: json['bannerImage'] as String?,
      profileImage: json['profileImage'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool?,
      cartCount: (json['cartCount'] as num?)?.toInt(),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      city: json['city'] as String?,
      telephone: json['telephone'] as String?,
      postcode: json['postcode'] as String?,
      region_id: json['region_id'] as String?,
      country_id: json['country_id'] as String?,
      street:
          (json['street'] as List<dynamic>?)?.map((e) => e as String).toList(),
      default_billing: (json['default_billing'] as num?)?.toInt(),
      default_shipping: (json['default_shipping'] as num?)?.toInt(),
      company: json['company'] as String?,
      customerId: json['customerId'] as String?,
    );

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'bannerImage': instance.bannerImage,
      'profileImage': instance.profileImage,
      'isEmailVerified': instance.isEmailVerified,
      'cartCount': instance.cartCount,
      'customerId': instance.customerId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'city': instance.city,
      'telephone': instance.telephone,
      'postcode': instance.postcode,
      'region_id': instance.region_id,
      'country_id': instance.country_id,
      'street': instance.street,
      'default_billing': instance.default_billing,
      'default_shipping': instance.default_shipping,
      'company': instance.company,
    };
