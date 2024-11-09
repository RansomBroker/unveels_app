/*
 *


 *
 * /
 */

// import 'package:json_annotation/json_annotation.dart';
// import 'package:test_new/unvells/models/address/zone.dart';
//
// part 'country_datum.g.dart';
//
// @JsonSerializable()
// class CountryDatum {
//   @JsonKey(name: "country_id")
//   String? countryId;
//
//   @JsonKey(name: "name")
//   String? name;
//
//   @JsonKey(name: "zone")
//   List<Zone>? zone;
//
//   CountryDatum({
//     this.countryId,
//     this.name,
//     this.zone,
//   });
//
//   Zone? getZoneById(String? zoneId) {
//     for (var cur in (zone ?? <Zone>[])) {
//       if (cur.zoneId == zoneId) {
//         return cur;
//       }
//     }
//     return zone?.isNotEmpty == false ? zone?.elementAt(0) : null;
//   }
//
//   Zone? getZoneByName(String? name) {
//     for (var cur in (zone ?? <Zone>[])) {
//       if (cur.name?.toLowerCase() == name?.toLowerCase()) {
//         return cur;
//       }
//     }
//     return zone?.isNotEmpty == false ? zone?.elementAt(0) : null;
//   }
//
//   factory CountryDatum.fromJson(Map<String, dynamic> json) =>
//       _$CountryDatumFromJson(json);
//
//   Map<String, dynamic> toJson() => _$CountryDatumToJson(this);
// }
