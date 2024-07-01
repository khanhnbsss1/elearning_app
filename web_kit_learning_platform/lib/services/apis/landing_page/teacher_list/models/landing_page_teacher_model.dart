class LandingPageUserListModel {
  List<LandingPageUserInfo>? data;

  LandingPageUserListModel({this.data});

  LandingPageUserListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LandingPageUserInfo>[];
      json['data'].forEach((v) {
        data!.add(new LandingPageUserInfo.fromJson(v));
      });
    }
  }
  LandingPageUserListModel.fromJsonList(dynamic json) {
    if (json != null) {
      data = <LandingPageUserInfo>[];
      json.forEach((v) {
        data!.add(new LandingPageUserInfo.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataOutPut = <String, dynamic>{};
    if (data != null) {
      dataOutPut['data'] = data!.map((v) => v.toJson()).toList();
    }
    return dataOutPut;
  }
}

class LandingPageUserInfo {
  int? id;
  String? fullname;
  String? avatar;
  String? position;
  int? isShow;

  LandingPageUserInfo(
      {this.id,
        this.fullname,
        this.avatar,
        this.position,
        this.isShow});

  LandingPageUserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['name'];
    avatar = json['avatar'];
    position = json['position'];
    isShow = json['is_show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = fullname;
    data['avatar'] = avatar;
    data['position'] = position;
    data['is_show'] = isShow;
    return data;
  }
}
