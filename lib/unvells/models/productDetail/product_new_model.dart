import '../../helper/app_storage_pref.dart';
import '../base_model.dart';

class ProductsNewModel extends BaseModel {
  List<ProductNewItems>? items;
  List<BssGetListTimezone>? bssGetListTimezone;

  ProductsNewModel({this.items, this.bssGetListTimezone});

  ProductsNewModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <ProductNewItems>[];
      json['items'].forEach((v) {
        items!.add(ProductNewItems.fromJson(v));
      });
    }
    if (json['bssGetListTimezone'] != null) {
      bssGetListTimezone = <BssGetListTimezone>[];
      json['bssGetListTimezone'].forEach((v) {
        bssGetListTimezone!.add(BssGetListTimezone.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (bssGetListTimezone != null) {
      data['bssGetListTimezone'] =
          bssGetListTimezone!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductNewItems {
  GiftcardOptions? giftcardOptions;
  int? isProductTryOn;
  int? is_product_skin_try;
  String? name;
  int? id;
  String? type_id;
  String? image;

  ProductNewItems({this.giftcardOptions, this.isProductTryOn,this.is_product_skin_try,this.name, this.id,this.type_id,this.image});

  ProductNewItems.fromJson(Map<String, dynamic> json) {
    giftcardOptions = json['giftcard_options'] != null
        ? GiftcardOptions.fromJson(json['giftcard_options'])
        : null;
    isProductTryOn = json['is_product_try_on'];
    is_product_skin_try = json['is_product_skin_try'];
    name = json['name'];
    id = json['id'];
    type_id = json['type_id'];
    image = json['image']['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (giftcardOptions != null) {
      data['giftcard_options'] = giftcardOptions!.toJson();
    }
    data['is_product_try_on'] = isProductTryOn;
    data['is_product_skin_try'] = is_product_skin_try;
    return data;
  }
}

class GiftcardOptions {
  String? expiresAt;
  int? message;
  int? type;
  List<Amount>? amount;
  List<Template>? template;

  GiftcardOptions(
      {this.expiresAt, this.message, this.type, this.amount, this.template});

  GiftcardOptions.fromJson(Map<String, dynamic> json) {
    expiresAt = json['expires_at'];
    message = json['message'];
    type = json['type'];
    if (json['amount'] != null) {
      amount = <Amount>[];
      json['amount'].forEach((v) {
        amount!.add(Amount.fromJson(v));
      });
    }
    if (json['template'] != null) {
      template = <Template>[];
      json['template'].forEach((v) {
        template!.add(Template.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expires_at'] = expiresAt;
    data['message'] = message;
    data['type'] = type;
    if (amount != null) {
      data['amount'] = amount!.map((v) => v.toJson()).toList();
    }
    if (template != null) {
      data['template'] = template!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Amount {
  int? id;
  String? price;
  int? value;
  int? website;

  Amount({this.id, this.price, this.value, this.website});

  Amount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'].toString();
    value = json['value'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['value'] = value;
    data['website'] = website;
    return data;
  }
}

class Template {
  String? codeColor;
  String? messageColor;
  String? name;
  int? status;
  int? templateId;
  List<TemplateImages>? images;

  Template(
      {this.codeColor,
        this.messageColor,
        this.name,
        this.status,
        this.templateId,
        this.images});

  Template.fromJson(Map<String, dynamic> json) {
    codeColor = json['code_color'];
    messageColor = json['message_color'];
    name = json['name'];
    status = json['status'];
    templateId = json['template_id'];
    if (json['images'] != null) {
      images = <TemplateImages>[];
      json['images'].forEach((v) {
        images!.add(TemplateImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code_color'] = codeColor;
    data['message_color'] = messageColor;
    data['name'] = name;
    data['status'] = status;
    data['template_id'] = templateId;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TemplateImages {
  int? id;
  int? position;
  String? thumbnail;
  String? url;

  TemplateImages({this.id, this.position, this.thumbnail, this.url});

  TemplateImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    position = json['position'];
    thumbnail = json['thumbnail'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['position'] = position;
    data['thumbnail'] = thumbnail;
    data['url'] = url;
    return data;
  }
}

class BssGetListTimezone {
  String? label;
  String? value;

  BssGetListTimezone({this.label, this.value});

  BssGetListTimezone.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}
