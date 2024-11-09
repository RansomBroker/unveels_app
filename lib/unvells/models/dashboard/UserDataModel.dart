/*
 *
  

 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

part 'UserDataModel.g.dart';

@JsonSerializable()
class UserDataModel {
  String? email;
  String? name;
  String? bannerImage;
  String? profileImage;
  bool? isEmailVerified;
  int? cartCount;
  String? customerId;
  String? firstName;
  String? lastName;
  String? city;
  String? telephone;
  String? postcode;
  String? region_id;
  String? country_id;
  List<String>? street;
  int? default_billing;
  int? default_shipping;
  String? company;


  UserDataModel(
      {this.email,
      this.name,
      this.bannerImage,
      this.profileImage,
      this.isEmailVerified,
      this.cartCount,
      this.firstName,
      this.lastName,
      this.city,
      this.telephone,
      this.postcode,
      this.region_id,
      this.country_id,
      this.street,
      this.default_billing,
      this.default_shipping,
      this.company,
      this.customerId});

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);

}
