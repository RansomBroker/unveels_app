class LookBookCategoriesModel {
  LookCategoriesData? data;

  LookBookCategoriesModel({this.data});

  LookBookCategoriesModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? LookCategoriesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LookCategoriesData {
  List<LookBookCategories>? lookBookCategories;

  LookCategoriesData({this.lookBookCategories});

  LookCategoriesData.fromJson(Map<String, dynamic> json) {
    if (json['lookBookCategories'] != null) {
      lookBookCategories = <LookBookCategories>[];
      json['lookBookCategories'].forEach((v) {
        lookBookCategories!.add(LookBookCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lookBookCategories != null) {
      data['lookBookCategories'] =
          lookBookCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LookBookCategories {
  int? categoryId;
  String? identifier;
  String? image;
  int? includeInMenu;
  int? isActive;
  String? metaDescription;
  String? metaKeywords;
  String? metaTitle;
  int? position;
  List<int>? storeId;
  String? title;
  List<Profiles>? profiles;

  LookBookCategories(
      {this.categoryId,
        this.identifier,
        this.image,
        this.includeInMenu,
        this.isActive,
        this.metaDescription,
        this.metaKeywords,
        this.metaTitle,
        this.position,
        this.storeId,
        this.title,
        this.profiles});

  LookBookCategories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    identifier = json['identifier'];
    image = json['image'];
    includeInMenu = json['include_in_menu'];
    isActive = json['is_active'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    metaTitle = json['meta_title'];
    position = json['position'];
    storeId = json['store_id'].cast<int>();
    title = json['title'];
    if (json['profiles'] != null) {
      profiles = <Profiles>[];
      json['profiles'].forEach((v) {
        profiles!.add(Profiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['identifier'] = identifier;
    data['image'] = image;
    data['include_in_menu'] = includeInMenu;
    data['is_active'] = isActive;
    data['meta_description'] = metaDescription;
    data['meta_keywords'] = metaKeywords;
    data['meta_title'] = metaTitle;
    data['position'] = position;
    data['store_id'] = storeId;
    data['title'] = title;
    if (profiles != null) {
      data['profiles'] = profiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profiles {
  String? description;
  String? identifier;
  String? image;
  String? marker;
  String? name;
  String? pageLayout;
  int? profileId;
  List<int>? storeId;
  String? tryOnUrl;

  Profiles(
      {this.description,
        this.identifier,
        this.image,
        this.marker,
        this.name,
        this.pageLayout,
        this.profileId,
        this.storeId,
        this.tryOnUrl});

  Profiles.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    identifier = json['identifier'];
    image = json['image'];
    marker = json['marker'];
    name = json['name'];
    pageLayout = json['page_layout'];
    profileId = json['profile_id'];
    storeId = json['store_id'].cast<int>();
    tryOnUrl = json['try_on_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['identifier'] = identifier;
    data['image'] = image;
    data['marker'] = marker;
    data['name'] = name;
    data['page_layout'] = pageLayout;
    data['profile_id'] = profileId;
    data['store_id'] = storeId;
    data['try_on_url'] = tryOnUrl;
    return data;
  }
}
