enum UserTypeName{
  teacher,
  user
}
Map<UserTypeName, String>typeNameToStr={
  UserTypeName.teacher:"Teacher",
  UserTypeName.user:"User",

};
class ReviewListLandingPageResponseModel {
  List<ReviewLandingPageInfo>? data;

  ReviewListLandingPageResponseModel({this.data});
  ReviewListLandingPageResponseModel.fromJsonList(dynamic json) {
    if (json != null) {
      data = <ReviewLandingPageInfo>[];
      json.forEach((v) {
        data!.add(new ReviewLandingPageInfo.fromJson(v));
      });
    }
  }
  ReviewListLandingPageResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ReviewLandingPageInfo>[];
      json['data'].forEach((v) {
        data!.add(new ReviewLandingPageInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataOutput = <String, dynamic>{};
    if (data != null) {
      dataOutput['data'] = data!.map((v) => v.toJson()).toList();
    }
    return dataOutput;
  }
}

class ReviewLandingPageInfo {
  int? id;
  String? name;
  String? position;
  String? review;
  String? typeName;
  String? avatar;
  int? isShow;
  int? fileId;
  ReviewLandingPageInfo(
      {this.id,
        this.name,
        this.position,
        this.review,
        this.typeName,
        this.avatar,
        this.isShow,
        this.fileId
      });

  ReviewLandingPageInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    
    name = json['name'];
    position = json['position'];
    review = json['review'];
    typeName = json['type_name'];
    avatar = json['avatar'];
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
    data['position'] = position;
    data['review'] = review;
    data['type_name'] = typeName;
    data['avatar'] = avatar;
    data['is_show'] = isShow;
    data['file_id'] = fileId;

    return data;
  }
}
