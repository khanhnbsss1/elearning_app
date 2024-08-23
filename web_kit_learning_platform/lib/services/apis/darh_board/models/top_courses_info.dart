class TopCoursesInfoResponseModel {
  List<TopCoursesInfo>? data;

  TopCoursesInfoResponseModel({this.data});

  TopCoursesInfoResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TopCoursesInfo>[];
      json['data'].forEach((v) {
        data!.add(new TopCoursesInfo.fromJson(v));
      });
    }
  }
  TopCoursesInfoResponseModel.fromJsonList(dynamic json) {
    if (json != null) {
      data = <TopCoursesInfo>[];
      json.forEach((v) {
        data!.add(new TopCoursesInfo.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopCoursesInfo {
  int? id;
  String? name;
  String? mode;
  int? ratePoint;

  TopCoursesInfo({this.id, this.name, this.mode, this.ratePoint});

  TopCoursesInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mode = json['mode'];
    ratePoint = json['rate_point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mode'] = mode;
    data['rate_point'] = ratePoint;
    return data;
  }
}
