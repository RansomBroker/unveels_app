/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/base_model.dart';

import 'home_page_languages.dart';
part 'home_page_language.g.dart';


@JsonSerializable()
class LanguageData extends BaseModel {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "stores")
  List<Language>? stores;

  LanguageData({this.id, this.name, this.stores});

  factory LanguageData.fromJson(Map<String, dynamic> json) =>
      _$LanguageDataFromJson(json);


  Map<String, dynamic> toJson() => _$LanguageDataToJson(this);
}
