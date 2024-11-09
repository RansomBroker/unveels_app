
/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
part 'option_value.g.dart';

@JsonSerializable()
class OptionValue{
  String? title;
  String? isQtyUserDefined;
  String? isDefault;
  String? optionId;
  String? optionValueId;
  String? foramtedPrice;
  double? price;
  bool? isSingle;
  String? defaultQty;

  OptionValue(
      this.title,
      this.isQtyUserDefined,
      this.isDefault,
      this.optionId,
      this.optionValueId,
      this.foramtedPrice,
      this.price,
      this.isSingle,
      this.defaultQty,);

  factory OptionValue.fromJson(Map<String, dynamic> json) =>
      _$OptionValueFromJson(json);

  Map<String, dynamic> toJson() => _$OptionValueToJson(this);


}