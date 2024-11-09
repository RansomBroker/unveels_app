/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

import '../../address/address_form_data.dart';

part 'shipping_address_model.g.dart';

@JsonSerializable()
class ShippingAddressModel{
  bool? success;
  String? message;
  String? lastName;
  String? firstName;
  String? middleName;
  String? prefixValue;
  String? suffixValue;
  int? cartCount;
  bool? isVirtual;
  int? streetLineCount;
  String? defaultCountry;
  bool? allowToChooseState;
  List<Address>? address;
  Address? selectedAddressData;

  bool? hasNewAddress;

  ShippingAddressModel({this.success, this.message, this.cartCount, this.address, this.allowToChooseState, this.defaultCountry, this.firstName, this.isVirtual, this.lastName, this.middleName, this.prefixValue, this.streetLineCount, this.suffixValue});

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressModelToJson(this);



  String getFormattedAddress (AddressDataModel addressDataModel) {


    String formattedAddress = '${addressDataModel.firstname} ${addressDataModel.middlename} ${addressDataModel.lastname} <br/>';

    addressDataModel.street?.forEach((element) {
      formattedAddress = '$formattedAddress  ${element.toString()} <br/>';
    });
    if (addressDataModel.city.toString().isNotEmpty) {
      formattedAddress = '$formattedAddress  ${addressDataModel.city.toString()},';
    }
    if (addressDataModel.region !=null) {
      formattedAddress = '$formattedAddress  ${addressDataModel.region}';
    }

    if (addressDataModel.postcode.toString().isNotEmpty) {
      formattedAddress = '$formattedAddress  ${addressDataModel.postcode.toString()} <br/>';
    }

    formattedAddress = '$formattedAddress  ${addressDataModel.countryName.toString()}';

   return formattedAddress.toString().trim();
  }

}

@JsonSerializable()
class Address {
  String? value;
  String? id;
  bool? isNew;

  Address({
    this.value,
    this.id,
    this.isNew});
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}



