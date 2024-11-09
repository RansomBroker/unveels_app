/*
 *


 *
 * /
 */

// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel extends BaseModel {
  String? customerEmail;
  String? customerName;
  String? customerId;
  String? customerToken;
  String? bearerToken;
  int? cartCount;
  String? profileImage;
  String? bannerImage;

  LoginResponseModel({
    this.customerEmail,
    this.customerName,
    this.customerId,
    this.customerToken,
    this.cartCount,
    this.profileImage,
    this.bannerImage,
    this.bearerToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
