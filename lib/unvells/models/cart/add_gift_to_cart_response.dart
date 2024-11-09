import 'package:test_new/unvells/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_gift_to_cart_response.g.dart'; // This is the generated file

@JsonSerializable()
class Cart {
  final int? total_quantity;

  Cart({this.total_quantity});

  factory Cart.fromJson(Map<String, dynamic> json) =>
      _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable()
class AddGiftToCartResponse extends BaseModel {
  final Cart? cart;

  AddGiftToCartResponse({this.cart});

  factory AddGiftToCartResponse.fromJson(Map<String, dynamic> json) =>
      _$AddGiftToCartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddGiftToCartResponseToJson(this);
}
