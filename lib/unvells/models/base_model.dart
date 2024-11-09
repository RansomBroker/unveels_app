/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
part 'base_model.g.dart';


@JsonSerializable()
class BaseModel {
  bool? success;
  String? message;
  String? otherError;
  String? redirect;
  String? eTag;
  int? cartCount;
  bool? transferValidation;

  BaseModel({
    this.success,
    this.message,
    this.otherError,
    this.redirect,
    this.cartCount,
    this.transferValidation,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}
