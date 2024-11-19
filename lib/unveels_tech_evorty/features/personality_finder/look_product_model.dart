class LookPacketModel {
  int? categoryId;
  String? identifier;
  String? title;
  int? isActive;
  int? position;
  int? includeInMenu;
  String? canonicalUrl;
  dynamic image;
  dynamic description;
  String? metaTitle;
  String? metaKeywords;
  String? metaDescription;
  List<String>? storeId;
  List<LookProfiles>? profiles;

  LookPacketModel({
    this.categoryId,
    this.identifier,
    this.title,
    this.isActive,
    this.position,
    this.includeInMenu,
    this.canonicalUrl,
    this.image,
    this.description,
    this.metaTitle,
    this.metaKeywords,
    this.metaDescription,
    this.storeId,
    this.profiles,
  });

  LookPacketModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    identifier = json['identifier'];
    title = json['title'];
    isActive = json['is_active'];
    position = json['position'];
    includeInMenu = json['include_in_menu'];
    canonicalUrl = json['canonical_url'];
    image = json['image'];
    description = json['description'];
    metaTitle = json['meta_title'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];

    // Handling store_id
    storeId =
        json['store_id'] != null ? List<String>.from(json['store_id']) : [];

    // Handling profiles (Check if 'profiles' exists and is a List)
    if (json['profiles'] != null) {
      profiles = [];
      json['profiles'].forEach((v) {
        profiles!.add(LookProfiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['category_id'] = categoryId;
    data['identifier'] = identifier;
    data['title'] = title;
    data['is_active'] = isActive;
    data['position'] = position;
    data['include_in_menu'] = includeInMenu;
    data['canonical_url'] = canonicalUrl;
    data['image'] = image;
    data['description'] = description;
    data['meta_title'] = metaTitle;
    data['meta_keywords'] = metaKeywords;
    data['meta_description'] = metaDescription;
    data['store_id'] = storeId;

    // If profiles is not null, map the list of LookProfiles to JSON
    if (profiles != null) {
      data['profiles'] = profiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LookProfiles {
  int? profileId;
  String? name;
  String? description;
  String? image;
  String? identifier;
  String? marker;
  String? pageLayout;
  String? tryOnUrl;
  List<String>? storeId;

  LookProfiles({
    this.profileId,
    this.name,
    this.description,
    this.image,
    this.identifier,
    this.marker,
    this.pageLayout,
    this.tryOnUrl,
    this.storeId,
  });

  LookProfiles.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    identifier = json['identifier'];
    marker = json['marker'];
    pageLayout = json['page_layout'];
    tryOnUrl = json['try_on_url'];

    // Handling store_id for profiles
    storeId =
        json['store_id'] != null ? List<String>.from(json['store_id']) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['profile_id'] = profileId;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['identifier'] = identifier;
    data['marker'] = marker;
    data['page_layout'] = pageLayout;
    data['try_on_url'] = tryOnUrl;
    data['store_id'] = storeId;
    return data;
  }
}
