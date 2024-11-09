/*
 *
  

 *
 * /
 */

// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';

part 'sign_up_screen_model.g.dart';

@JsonSerializable()
class SignUpScreenModel extends BaseModel{
bool? isPrefixVisible;
bool? isPrefixRequired;
List<String>? prefixOptions;
bool? prefixHasOptions;
bool? isMiddlenameVisible;
bool? isMiddlenameRequired;
bool? isSuffixVisible;
bool? isSuffixRequired;
List<String>? suffixOptions;
bool? suffixHasOptions;
bool? isMobileVisible;
bool? isMobileRequired;
bool? isDOBVisible;
bool? isDOBRequired;
bool? isTaxRequired;
bool? isTaxVisible;
bool? isGenderRequired;
bool? isGenderVisible;
String? dateFormat;

String? prefix = "";
String? suffix = "";
String? gender = "";

SignUpScreenModel(
      {this.isPrefixVisible,
      this.isPrefixRequired,
      this.prefixOptions,
      this.prefixHasOptions,
      this.isMiddlenameVisible,
      this.isSuffixVisible,
      this.isSuffixRequired,
      this.suffixOptions,
      this.suffixHasOptions,
      this.isMobileVisible,
      this.isMobileRequired,
      this.isDOBVisible,
      this.isDOBRequired,
      this.isTaxRequired,
      this.isTaxVisible,
      this.isGenderRequired,
      this.isGenderVisible,
      this.dateFormat});

  factory SignUpScreenModel.fromJson(Map<String, dynamic> json) =>
    _$SignUpScreenModelFromJson(json);

Map<String, dynamic> toJson() => _$SignUpScreenModelToJson(this);
}

