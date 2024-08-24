class SubscriptionPurchasesInfoResponseModel {
  List<SubscriptionPurchasesInfo>? data;

  SubscriptionPurchasesInfoResponseModel({this.data});

  SubscriptionPurchasesInfoResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SubscriptionPurchasesInfo>[];
      json['data'].forEach((v) {
        data!.add(new SubscriptionPurchasesInfo.fromJson(v));
      });
    }
  }
  SubscriptionPurchasesInfoResponseModel.fromJsonList(dynamic json) {
    if (json != null) {
      data = <SubscriptionPurchasesInfo>[];
      json.forEach((v) {
        data!.add(new SubscriptionPurchasesInfo.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubscriptionPurchasesInfo {
  String? dateValue;
  int? totalAmount;

  SubscriptionPurchasesInfo({this.dateValue, this.totalAmount});

  SubscriptionPurchasesInfo.fromJson(Map<String, dynamic> json) {
    dateValue = (json['date_value'] as String).split(" ").first;
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_value'] = dateValue;
    data['total_amount'] = totalAmount;
    return data;
  }
}
