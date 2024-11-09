/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
part 'home_page_languages.g.dart';

@JsonSerializable()
class Language {
  int? id;
  String? code;
  String? name;

  Language({this.id, this.code, this.name});

factory Language.fromJson(Map<String, dynamic> json) =>
    _$LanguageFromJson(json);

Map<String, dynamic> toJson() => _$LanguageToJson(this);
}