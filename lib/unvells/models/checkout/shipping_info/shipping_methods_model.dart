/*
 *
  

 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

part 'shipping_methods_model.g.dart';

@JsonSerializable()
class ShippingMethodsModel{
  bool? success;
  String? message;
  String? cartTotal;
  int? cartCount;
  List<ShippingMethods>? shippingMethods;

  ShippingMethodsModel({this.success, this.message, this.cartCount, this.cartTotal, this.shippingMethods});

  factory ShippingMethodsModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingMethodsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingMethodsModelToJson(this);

}

@JsonSerializable()
class ShippingMethods {
  bool? isSelected;
  String? title;
  List<Method>? method;

  ShippingMethods({
    this.title,
    this.isSelected, this.method,});
  factory ShippingMethods.fromJson(Map<String, dynamic> json) =>
      _$ShippingMethodsFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingMethodsToJson(this);
}

@JsonSerializable()
class Method{
  String? code;
  String? label;
  String? price;

  Method({this.code, this.label, this.price});

  factory Method.fromJson(Map<String, dynamic> json) =>
      _$MethodFromJson(json);

  Map<String, dynamic> toJson() => _$MethodToJson(this);
}
