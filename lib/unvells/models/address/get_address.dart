/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/address/address_datum.dart';
import 'package:test_new/unvells/models/address/billing_address_datum.dart';
import 'package:test_new/unvells/models/address/shipping_address_datum.dart';
import 'package:test_new/unvells/models/base_model.dart';

part 'get_address.g.dart';

@JsonSerializable()
class GetAddress extends BaseModel {
  @JsonKey(name: "billingAddress")
  BillingAddressDatum? billingAddress;

  @JsonKey(name: "shippingAddress")
 ShippingAddressDatum? shippingAddress;

  @JsonKey(name: "additionalAddress")
  List<AddressDatum>? additionalAddress;

  @JsonKey(name: "addressCount")
  int? addressCount;

  GetAddress({this.billingAddress, this.shippingAddress, this.additionalAddress, this.addressCount});

  factory GetAddress.fromJson(Map<String, dynamic> json) {
    return _$GetAddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetAddressToJson(this);
}

