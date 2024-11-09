/*
 *


 *
 * /
 */

// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';

part 'signup_response_model.g.dart';


@JsonSerializable()
class SignupResponseModel extends BaseModel{
  String? customerEmail;
  String? customerName;
  String? customerId;
  String? customerToken;
  String? bearerToken;

  int? cartCount;
  String? profileImage;
  String? bannerImage;


  SignupResponseModel(
      {this.customerEmail,
      this.customerName,
      this.customerId,
      this.customerToken,
      this.cartCount,
      this.profileImage,
      this.bannerImage,
        this.bearerToken
      });


  factory SignupResponseModel.fromJson(Map<String, dynamic> json) => _$SignupResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupResponseModelToJson(this);



}