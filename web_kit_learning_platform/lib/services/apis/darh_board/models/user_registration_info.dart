class UserRegistrationInfoResponseModel {
  List<UserRegistrationInfo>? data;

  UserRegistrationInfoResponseModel({this.data});

  UserRegistrationInfoResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserRegistrationInfo>[];
      json['data'].forEach((v) {
        data!.add(new UserRegistrationInfo.fromJson(v));
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

class UserRegistrationInfo {
  String? dateValue;
  int? total;

  UserRegistrationInfo({this.dateValue, this.total});

  UserRegistrationInfo.fromJson(Map<String, dynamic> json) {
    dateValue = json['date_value'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_value'] = dateValue;
    data['total'] = total;
    return data;
  }
}
