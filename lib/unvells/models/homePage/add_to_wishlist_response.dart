/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';
import 'home_page_currency.dart';
part 'add_to_wishlist_response.g.dart';

@JsonSerializable()
class AddToWishlistResponse extends BaseModel {
  @JsonKey(name: "itemId")
  int? itemId;


  AddToWishlistResponse(
      {this.itemId,});

  factory AddToWishlistResponse.fromJson(Map<String, dynamic> json) =>
      _$AddToWishlistResponseFromJson(json);


  Map<String, dynamic> toJson() => _$AddToWishlistResponseToJson(this);

}