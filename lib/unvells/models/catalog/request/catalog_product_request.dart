/*
 *
  

 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/catalog/sorting_data.dart';

part 'catalog_product_request.g.dart';

@JsonSerializable()
class CatalogProductRequest {
  int? page;
  String? id;
  String? category_id;
  String? type;
  Map<String, String>? sortData;
  List<Map<String, String>>? filterData;

  CatalogProductRequest({
    this.page,
    this.id,
    this.type,
    this.sortData,
    this.filterData,
    this.category_id,
  });

  factory CatalogProductRequest.fromJson(Map<String, dynamic> json) =>
      _$CatalogProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CatalogProductRequestToJson(this);
}
