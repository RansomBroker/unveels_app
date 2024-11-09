/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';

part 'account_info_model.g.dart';

@JsonSerializable()
class AccountInfoModel extends BaseModel {
  String? firstName;
  String? lastName;
  String? email;
  String? telephone;
  String? fax;
  int? status;
  List<dynamic>? customField;
  List<String>? prefixOptions;
  List<String>? suffixOptions;
  String? bannerImage;
  String? profileImage;
  String? middleName;
  bool? isPrefixVisible;
  bool? isPrefixRequired;
  String? prefixValue;
  bool? prefixHasOptions;
  bool? isMiddlenameVisible;
  bool? isSuffixVisible;
  bool? isSuffixRequired;
  String? suffixValue;
  bool? suffixHasOptions;
  bool? isMobileVisible;
  bool? isMobileRequired;
  bool? isDOBVisible;
  bool? isDOBRequired;
  String? DOBValue;
  bool? isTaxVisible;
  bool? isTaxRequired;
  String? taxValue;
  bool? isGenderVisible;
  bool? isGenderRequired;
  String? genderValue;
  bool? isFaxVisible;
  bool? isFaxRequired;
  bool? isTelephoneVisible;
  bool? isTelephoneRequired;
  String? dateFormat;
  String? url;

  String? prefix = "";
  String? suffix = "";
  String? gender = "";

  AccountInfoModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.telephone,
      this.fax,
      this.status,
      this.customField,
      this.bannerImage,
      this.profileImage,
      this.prefixOptions,
      this.suffixOptions,
        this.middleName,
        this.isPrefixVisible,
        this.isPrefixRequired,
        this.prefixValue,
        this.prefixHasOptions,
        this.isMiddlenameVisible,
        this.isSuffixVisible,
        this.isSuffixRequired,
        this.suffixValue,
        this.suffixHasOptions,
        this.isMobileVisible,
        this.isMobileRequired,
        this.isDOBVisible,
        this.isDOBRequired,
        this.DOBValue,
        this.isTaxVisible,
        this.isTaxRequired,
        this.taxValue,
        this.isGenderVisible,
        this.isGenderRequired,
        this.genderValue,
        this.isFaxVisible,
        this.isFaxRequired,
        this.isTelephoneVisible,
        this.isTelephoneRequired,
        this.dateFormat,
        this.url,
      });


  factory AccountInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoModelToJson(this);
}
