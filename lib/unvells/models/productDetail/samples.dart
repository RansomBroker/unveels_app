/*
 *


 *
 * /
 */

import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'linked_sample_data.dart';
import 'option_value.dart';
part 'samples.g.dart';

@JsonSerializable()
class Samples{
  bool? hasSample;
  String? title;
  List<LinkedSampleData>? linkSampleData;

  Samples(this.hasSample, this.title, this.linkSampleData);

  factory Samples.fromJson(Map<String, dynamic> json) =>
      _$SamplesFromJson(json);

  Map<String, dynamic> toJson() => _$SamplesToJson(this);
}