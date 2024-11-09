class CustomerCartModel {
  CustomerCartData? customerCart;

  CustomerCartModel({this.customerCart});

  CustomerCartModel.fromJson(Map<String, dynamic> json) {
    customerCart = json['customerCart'] != null
        ? CustomerCartData.fromJson(json['customerCart'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customerCart != null) {
      data['customerCart'] = customerCart!.toJson();
    }
    return data;
  }
}

class CustomerCartData {
  String? email;
  String? id;
  bool? isVirtual;
  int? totalQuantity;
  MstRewardPoints? mstRewardPoints;

  CustomerCartData(
      {this.email,
        this.id,
        this.isVirtual,
        this.totalQuantity,
        this.mstRewardPoints});

  CustomerCartData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    isVirtual = json['is_virtual'];
    totalQuantity = json['total_quantity'];
    mstRewardPoints = json['mstRewardPoints'] != null
        ? MstRewardPoints.fromJson(json['mstRewardPoints'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['id'] = id;
    data['is_virtual'] = isVirtual;
    data['total_quantity'] = totalQuantity;
    if (mstRewardPoints != null) {
      data['mstRewardPoints'] = mstRewardPoints!.toJson();
    }
    return data;
  }
}

class MstRewardPoints {
  num? earnPoints;
  bool? isApplied;
  num? spendMaxPoints;
  num? spendMinPoints;
  num? spendPoints;
  BaseSpendAmount? baseSpendAmount;
  BaseSpendAmount? spendAmount;

  MstRewardPoints(
      {this.earnPoints,
        this.isApplied,
        this.spendMaxPoints,
        this.spendMinPoints,
        this.spendPoints,
        this.baseSpendAmount,
        this.spendAmount});

  MstRewardPoints.fromJson(Map<String, dynamic> json) {
    earnPoints = json['earn_points'];
    isApplied = json['is_applied'];
    spendMaxPoints = json['spend_max_points'];
    spendMinPoints = json['spend_min_points'];
    spendPoints = json['spend_points'];
    baseSpendAmount = json['base_spend_amount'] != null
        ? BaseSpendAmount.fromJson(json['base_spend_amount'])
        : null;
    spendAmount = json['spend_amount'] != null
        ? BaseSpendAmount.fromJson(json['spend_amount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['earn_points'] = earnPoints;
    data['is_applied'] = isApplied;
    data['spend_max_points'] = spendMaxPoints;
    data['spend_min_points'] = spendMinPoints;
    data['spend_points'] = spendPoints;
    if (baseSpendAmount != null) {
      data['base_spend_amount'] = baseSpendAmount!.toJson();
    }
    if (spendAmount != null) {
      data['spend_amount'] = spendAmount!.toJson();
    }
    return data;
  }
}

class BaseSpendAmount {
  String? currency;
  num? value;

  BaseSpendAmount({this.currency, this.value});

  BaseSpendAmount.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency'] = currency;
    data['value'] = value;
    return data;
  }
}
