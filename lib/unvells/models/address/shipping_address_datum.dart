/*
 *
  

 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

part 'shipping_address_datum.g.dart';

@JsonSerializable()
class ShippingAddressDatum {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "addressTitle")
  String? addressTitle;

  @JsonKey(name: "value")
  String? value;

  ShippingAddressDatum({this.id, this.addressTitle, this.value});

  factory ShippingAddressDatum.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressDatumFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressDatumToJson(this);
}
