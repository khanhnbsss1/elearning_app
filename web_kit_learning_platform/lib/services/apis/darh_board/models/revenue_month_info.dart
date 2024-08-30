class RevenueMonthResponseModel {
  List<RevenueMonthInfo>? data;

  RevenueMonthResponseModel({this.data});

  RevenueMonthResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RevenueMonthInfo>[];
      json['data'].forEach((v) {
        data!.add(new RevenueMonthInfo.fromJson(v));
      });
    }
  }
  RevenueMonthResponseModel.fromJsonList( dynamic json) {
    if (json != null) {
      data = <RevenueMonthInfo>[];
      json.forEach((v) {
        data!.add(new RevenueMonthInfo.fromJson(v));
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

class RevenueMonthInfo {
  String? month;
  int? totalAmount;

  RevenueMonthInfo({this.month, this.totalAmount});

  RevenueMonthInfo.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}
