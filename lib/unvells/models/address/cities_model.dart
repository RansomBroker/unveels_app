class CitiesListData {
  List<GetCitiesByRegion>? getCitiesByRegion;

  CitiesListData({this.getCitiesByRegion});

  CitiesListData.fromJson(Map<String, dynamic> json) {
    if (json['getCitiesByRegion'] != null) {
      getCitiesByRegion = <GetCitiesByRegion>[];
      json['getCitiesByRegion'].forEach((v) {
        getCitiesByRegion!.add(GetCitiesByRegion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getCitiesByRegion != null) {
      data['getCitiesByRegion'] =
          getCitiesByRegion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetCitiesByRegion {
  int? cityId;
  String? cityName;

  GetCitiesByRegion({this.cityId, this.cityName});

  GetCitiesByRegion.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city_id'] = cityId;
    data['city_name'] = cityName;
    return data;
  }

  // GetCitiesByRegion? getCityByName(String? name) {
  //   for (var cur in (states ?? <GetCitiesByRegion>[])) {
  //     if (cur.c?.toLowerCase() == name?.toLowerCase()) {
  //       return cur;
  //     }
  //   }
  //   return states?.isNotEmpty == false ? states?.elementAt(0) : null;
  // }
}
