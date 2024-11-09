/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

part 'linked_sample_data.g.dart';
@JsonSerializable()
class LinkedSampleData{

  String? sampleTitle;
  String? url;
  String? fileName;
  String? mimeType;

  LinkedSampleData(this.sampleTitle, this.url, this.fileName, this.mimeType);

  factory LinkedSampleData.fromJson(Map<String, dynamic> json) =>
      _$LinkedSampleDataFromJson(json);

  Map<String, dynamic> toJson() => _$LinkedSampleDataToJson(this);


}