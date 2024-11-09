/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/address/address_datum.dart';
import 'package:test_new/unvells/models/address/billing_address_datum.dart';
import 'package:test_new/unvells/models/address/cities_model.dart';
import 'package:test_new/unvells/models/address/shipping_address_datum.dart';
import 'package:test_new/unvells/models/base_model.dart';

part 'address_form_data.g.dart';

@JsonSerializable()
class CheckoutAddressFormDataModel extends BaseModel {
  @JsonKey(name: "lastName")
  dynamic lastName;

  @JsonKey(name: "firstName")
  dynamic firstName;

  @JsonKey(name: "addressData")
  AddressDataModel? addressData;

  @JsonKey(name: "isGuest")
  dynamic isGuest;

  @JsonKey(name: "address")
  List<AddressList>? address;

  @JsonKey(name: "countryData")
  List<CountryDataModel>? countryData;

  @JsonKey(name: "defaultCountry")
  String? defaultCountry;

  @JsonKey(name: "streetLineCount")
  int? streetLineCount;

  @JsonKey(name: "isPrefixVisible")
  bool? isPrefixVisible;

  bool? isPrefixRequired;
  List<String>? prefixOptions;
  bool? prefixHasOptions;
  bool? isMiddlenameVisible;
  bool? isMiddlenameRequired;
  bool? isSuffixVisible;
  bool? isSuffixRequired;
  List<String>? suffixOptions;
  bool? suffixHasOptions;
  bool? isMobileVisible;
  bool? isMobileRequired;
  bool? isDOBVisible;
  bool? isDOBRequired;
  bool? isTaxRequired;
  bool? isTaxVisible;
  bool? isGenderRequired;
  bool? isGenderVisible;
  String? dateFormat;

  bool? isCompanyRequired;
  bool? isCompanyVisible;
  bool? isFaxRequired;
  bool? isFaxVisible;

  String? prefix = "";
  String? suffix = "";
  String? gender = "";

  CountryDataModel? getCountryById(String? id) {
    for (var country in (countryData ?? <CountryDataModel?>[])) {
      if (country?.country_id == id || country?.name == id) {
        return country;
      }
    }
    return countryData?.isNotEmpty == true ? countryData?.elementAt(0) : null;
  }

  CountryDataModel? getCountryByName(String? countryName) {
    for (var country in (countryData ?? <CountryDataModel?>[])) {
      if (country?.name?.toLowerCase() == countryName?.toLowerCase()) {
        return country;
      }
    }
    return countryData?.isNotEmpty == true ? countryData?.elementAt(0) : null;
  }

  CheckoutAddressFormDataModel({
    this.lastName,
    this.firstName,
    this.addressData,
    this.isGuest,
    this.address,
    this.countryData,
    this.defaultCountry,
    this.streetLineCount,
    this.isPrefixVisible,
    this.isPrefixRequired,
    this.prefixOptions,
    this.prefixHasOptions,
    this.isMiddlenameVisible,
    this.isSuffixVisible,
    this.isSuffixRequired,
    this.suffixOptions,
    this.suffixHasOptions,
    this.isMobileVisible,
    this.isMobileRequired,
    this.isDOBVisible,
    this.isDOBRequired,
    this.isTaxRequired,
    this.isTaxVisible,
    this.isGenderRequired,
    this.isGenderVisible,
    this.dateFormat,
    this.isCompanyRequired,
    this.isCompanyVisible,
    this.isFaxRequired,
    this.isFaxVisible,
  });

  factory CheckoutAddressFormDataModel.fromJson(Map<String, dynamic> json) =>
      _$CheckoutAddressFormDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutAddressFormDataModelToJson(this);
}

@JsonSerializable()
class AddressList {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "value")
  String? value;

  AddressList({this.id, this.value});

  factory AddressList.fromJson(Map<String, dynamic> json) =>
      _$AddressListFromJson(json);

  Map<String, dynamic> toJson() => _$AddressListToJson(this);
}

@JsonSerializable()
class AddressDataModel {
  @JsonKey(name: "isDefaultBilling")
  dynamic isDefaultBilling;

  @JsonKey(name: "isDefualtShipping")
  dynamic isDefualtShipping;

  @JsonKey(name: "entity_id")
  dynamic entity_id;

  @JsonKey(name: "increment_id")
  dynamic increment_id;

  @JsonKey(name: "parent_id")
  dynamic parent_id;

  @JsonKey(name: "created_at")
  dynamic created_at;

  @JsonKey(name: "updated_at")
  dynamic updated_at;

  @JsonKey(name: "is_active")
  dynamic is_active;

  @JsonKey(name: "city")
  dynamic city;

  @JsonKey(name: "company")
  dynamic company;

  @JsonKey(name: "fax")
  dynamic fax;

  @JsonKey(name: "country_id")
  dynamic country_id;

  @JsonKey(name: "firstname")
  dynamic firstname;

  @JsonKey(name: "lastname")
  dynamic lastname;

  @JsonKey(name: "middlename")
  dynamic middlename;

  @JsonKey(name: "postcode")
  dynamic postcode;

  @JsonKey(name: "prifix")
  dynamic prifix;

  @JsonKey(name: "region")
  dynamic region;

  @JsonKey(name: "region_id")
  dynamic region_id;

  @JsonKey(name: "street")
  List<String>? street;

  @JsonKey(name: "suffix")
  dynamic suffix;

  @JsonKey(name: "telephone")
  dynamic telephone;

  @JsonKey(name: "vat_id")
  dynamic vat_id;

  @JsonKey(name: "vat_is_valid")
  dynamic vat_is_valid;

  @JsonKey(name: "vat_request_date")
  dynamic vat_request_date;

  @JsonKey(name: "vat_request_id")
  dynamic vat_request_id;

  @JsonKey(name: "var_request_success")
  dynamic var_request_success;

  @JsonKey(name: "email")
  dynamic email;

  dynamic countryName;

  dynamic saveAddress;

  List? custom_attributes;

  AddressDataModel(
      {this.isDefaultBilling,
      this.isDefualtShipping,
      this.entity_id,
      this.increment_id,
      this.parent_id,
      this.created_at,
      this.updated_at,
      this.is_active,
      this.city,
      this.company,
      this.fax,
      this.country_id,
      this.firstname,
      this.lastname,
      this.middlename,
      this.postcode,
      this.prifix,
      this.region,
      this.region_id,
      this.street,
      this.suffix,
      this.telephone,
      this.vat_id,
      this.vat_is_valid,
      this.vat_request_id,
      this.var_request_success,
      this.email,
      this.countryName,
      this.saveAddress,
      this.custom_attributes});

  factory AddressDataModel.fromJson(Map<String, dynamic> json) =>
      _$AddressDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDataModelToJson(this);
}

@JsonSerializable()
class CountryDataModel {
  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "country_id")
  String? country_id;

  @JsonKey(name: "isStateRequired")
  bool? isStateRequired;

  @JsonKey(name: "isZipOptional")
  dynamic isZipOptional;

  @JsonKey(name: "states")
  List<StatesDataModel>? states;

  CountryDataModel({
    this.name,
    this.country_id,
    this.isStateRequired,
    this.isZipOptional,
    this.states,
  });

  StatesDataModel? getStatesById(String? statesId) {
    for (var cur in (states ?? <StatesDataModel>[])) {
      if (cur.region_id == statesId) {
        return cur;
      }
    }
    return states?.isNotEmpty == false ? states?.elementAt(0) : null;
  }

  StatesDataModel? getStatesByName(String? name) {
    for (var cur in (states ?? <StatesDataModel>[])) {
      if (cur.name?.toLowerCase() == name?.toLowerCase()) {
        return cur;
      }
    }
    return states?.isNotEmpty == false ? states?.elementAt(0) : null;
  }

  factory CountryDataModel.fromJson(Map<String, dynamic> json) =>
      _$CountryDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryDataModelToJson(this);
}

@JsonSerializable()
class StatesDataModel {
  @JsonKey(name: "code")
  String? code;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "region_id")
  String? region_id;

  StatesDataModel({
    this.code,
    this.name,
    this.region_id,
  });

  factory StatesDataModel.fromJson(Map<String, dynamic> json) =>
      _$StatesDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatesDataModelToJson(this);
}
