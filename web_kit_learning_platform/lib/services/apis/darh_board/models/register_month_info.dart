class RegisterMonthResponseModel {
  List<RegisterMonthInfo>? data;

  RegisterMonthResponseModel({this.data});

  RegisterMonthResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RegisterMonthInfo>[];
      json['data'].forEach((v) {
        data!.add(new RegisterMonthInfo.fromJson(v));
      });
    }
  }
  RegisterMonthResponseModel.fromJsonList( dynamic json) {
    if (json != null) {
      data = <RegisterMonthInfo>[];
      json.forEach((v) {
        data!.add(new RegisterMonthInfo.fromJson(v));
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

class RegisterMonthInfo {
  String? month;
  int? totalUser;

  RegisterMonthInfo({this.month, this.totalUser});

  RegisterMonthInfo.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    totalUser = json['total_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['total_user'] = this.totalUser;
    return data;
  }
}
