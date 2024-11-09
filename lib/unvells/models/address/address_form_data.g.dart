// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_form_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutAddressFormDataModel _$CheckoutAddressFormDataModelFromJson(
        Map<String, dynamic> json) =>
    CheckoutAddressFormDataModel(
      lastName: json['lastName'],
      firstName: json['firstName'],
      addressData: json['addressData'] == null
          ? null
          : AddressDataModel.fromJson(
              json['addressData'] as Map<String, dynamic>),
      isGuest: json['isGuest'],
      address: (json['address'] as List<dynamic>?)
          ?.map((e) => AddressList.fromJson(e as Map<String, dynamic>))
          .toList(),
      countryData: (json['countryData'] as List<dynamic>?)
          ?.map((e) => CountryDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultCountry: json['defaultCountry'] as String?,
      streetLineCount: (json['streetLineCount'] as num?)?.toInt(),
      isPrefixVisible: json['isPrefixVisible'] as bool?,
      isPrefixRequired: json['isPrefixRequired'] as bool?,
      prefixOptions: (json['prefixOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      prefixHasOptions: json['prefixHasOptions'] as bool?,
      isMiddlenameVisible: json['isMiddlenameVisible'] as bool?,
      isSuffixVisible: json['isSuffixVisible'] as bool?,
      isSuffixRequired: json['isSuffixRequired'] as bool?,
      suffixOptions: (json['suffixOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      suffixHasOptions: json['suffixHasOptions'] as bool?,
      isMobileVisible: json['isMobileVisible'] as bool?,
      isMobileRequired: json['isMobileRequired'] as bool?,
      isDOBVisible: json['isDOBVisible'] as bool?,
      isDOBRequired: json['isDOBRequired'] as bool?,
      isTaxRequired: json['isTaxRequired'] as bool?,
      isTaxVisible: json['isTaxVisible'] as bool?,
      isGenderRequired: json['isGenderRequired'] as bool?,
      isGenderVisible: json['isGenderVisible'] as bool?,
      dateFormat: json['dateFormat'] as String?,
      isCompanyRequired: json['isCompanyRequired'] as bool?,
      isCompanyVisible: json['isCompanyVisible'] as bool?,
      isFaxRequired: json['isFaxRequired'] as bool?,
      isFaxVisible: json['isFaxVisible'] as bool?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?
      ..isMiddlenameRequired = json['isMiddlenameRequired'] as bool?
      ..prefix = json['prefix'] as String?
      ..suffix = json['suffix'] as String?
      ..gender = json['gender'] as String?;

Map<String, dynamic> _$CheckoutAddressFormDataModelToJson(
        CheckoutAddressFormDataModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'addressData': instance.addressData,
      'isGuest': instance.isGuest,
      'address': instance.address,
      'countryData': instance.countryData,
      'defaultCountry': instance.defaultCountry,
      'streetLineCount': instance.streetLineCount,
      'isPrefixVisible': instance.isPrefixVisible,
      'isPrefixRequired': instance.isPrefixRequired,
      'prefixOptions': instance.prefixOptions,
      'prefixHasOptions': instance.prefixHasOptions,
      'isMiddlenameVisible': instance.isMiddlenameVisible,
      'isMiddlenameRequired': instance.isMiddlenameRequired,
      'isSuffixVisible': instance.isSuffixVisible,
      'isSuffixRequired': instance.isSuffixRequired,
      'suffixOptions': instance.suffixOptions,
      'suffixHasOptions': instance.suffixHasOptions,
      'isMobileVisible': instance.isMobileVisible,
      'isMobileRequired': instance.isMobileRequired,
      'isDOBVisible': instance.isDOBVisible,
      'isDOBRequired': instance.isDOBRequired,
      'isTaxRequired': instance.isTaxRequired,
      'isTaxVisible': instance.isTaxVisible,
      'isGenderRequired': instance.isGenderRequired,
      'isGenderVisible': instance.isGenderVisible,
      'dateFormat': instance.dateFormat,
      'isCompanyRequired': instance.isCompanyRequired,
      'isCompanyVisible': instance.isCompanyVisible,
      'isFaxRequired': instance.isFaxRequired,
      'isFaxVisible': instance.isFaxVisible,
      'prefix': instance.prefix,
      'suffix': instance.suffix,
      'gender': instance.gender,
    };

AddressList _$AddressListFromJson(Map<String, dynamic> json) => AddressList(
      id: json['id'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$AddressListToJson(AddressList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };

AddressDataModel _$AddressDataModelFromJson(Map<String, dynamic> json) =>
    AddressDataModel(
      isDefaultBilling: json['isDefaultBilling'],
      isDefualtShipping: json['isDefualtShipping'],
      entity_id: json['entity_id'],
      increment_id: json['increment_id'],
      parent_id: json['parent_id'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      is_active: json['is_active'],
      city: json['city'],
      company: json['company'],
      fax: json['fax'],
      country_id: json['country_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      middlename: json['middlename'],
      postcode: json['postcode'],
      prifix: json['prifix'],
      region: json['region'],
      region_id: json['region_id'],
      street:
          (json['street'] as List<dynamic>?)?.map((e) => e as String).toList(),
      suffix: json['suffix'],
      telephone: json['telephone'],
      vat_id: json['vat_id'],
      vat_is_valid: json['vat_is_valid'],
      vat_request_id: json['vat_request_id'],
      var_request_success: json['var_request_success'],
      email: json['email'],
      countryName: json['countryName'],
      saveAddress: json['saveAddress'],
      custom_attributes: json['custom_attributes'] as List<dynamic>?,
    )..vat_request_date = json['vat_request_date'];

Map<String, dynamic> _$AddressDataModelToJson(AddressDataModel instance) =>
    <String, dynamic>{
      'isDefaultBilling': instance.isDefaultBilling,
      'isDefualtShipping': instance.isDefualtShipping,
      'entity_id': instance.entity_id,
      'increment_id': instance.increment_id,
      'parent_id': instance.parent_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'is_active': instance.is_active,
      'city': instance.city,
      'company': instance.company,
      'fax': instance.fax,
      'country_id': instance.country_id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'middlename': instance.middlename,
      'postcode': instance.postcode,
      'prifix': instance.prifix,
      'region': instance.region,
      'region_id': instance.region_id,
      'street': instance.street,
      'suffix': instance.suffix,
      'telephone': instance.telephone,
      'vat_id': instance.vat_id,
      'vat_is_valid': instance.vat_is_valid,
      'vat_request_date': instance.vat_request_date,
      'vat_request_id': instance.vat_request_id,
      'var_request_success': instance.var_request_success,
      'email': instance.email,
      'countryName': instance.countryName,
      'saveAddress': instance.saveAddress,
      'custom_attributes': instance.custom_attributes,
    };

CountryDataModel _$CountryDataModelFromJson(Map<String, dynamic> json) =>
    CountryDataModel(
      name: json['name'] as String?,
      country_id: json['country_id'] as String?,
      isStateRequired: json['isStateRequired'] as bool?,
      isZipOptional: json['isZipOptional'],
      states: (json['states'] as List<dynamic>?)
          ?.map((e) => StatesDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountryDataModelToJson(CountryDataModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'country_id': instance.country_id,
      'isStateRequired': instance.isStateRequired,
      'isZipOptional': instance.isZipOptional,
      'states': instance.states,
    };

StatesDataModel _$StatesDataModelFromJson(Map<String, dynamic> json) =>
    StatesDataModel(
      code: json['code'] as String?,
      name: json['name'] as String?,
      region_id: json['region_id'] as String?,
    );

Map<String, dynamic> _$StatesDataModelToJson(StatesDataModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'region_id': instance.region_id,
    };
