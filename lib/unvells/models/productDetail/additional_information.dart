/*
 *
  

 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
part 'additional_information.g.dart';

@JsonSerializable()
class AdditionalInformation{
  String? label;
  String? value;


  AdditionalInformation(this.label, this.value);

  factory AdditionalInformation.fromJson(Map<String, dynamic> json) =>
      _$AdditionalInformationFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalInformationToJson(this);
}