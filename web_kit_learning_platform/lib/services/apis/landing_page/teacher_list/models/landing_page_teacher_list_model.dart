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
  String? name;
  String? avatar;
  String? position;
  int? isShow;
  int?fileId;
  LandingPageUserInfo(
      {this.id,
        this.name,
        this.avatar,
        this.position,
        this.isShow});

  LandingPageUserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    position = json['position'];
    isShow = json['is_show'];
    fileId = json['file_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(id!=null)
      {
        data['id'] = id;
      }
    data['name'] = name;
    data['avatar'] = avatar;
    data['position'] = position;
    data['is_show'] = isShow;
    data['file_id'] = fileId;
    return data;
  }
}
