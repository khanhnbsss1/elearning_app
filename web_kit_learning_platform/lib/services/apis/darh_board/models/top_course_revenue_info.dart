class TopCourseRevenueResponseModel {
  List<TopCourseRevenueInfo>? data;

  TopCourseRevenueResponseModel({this.data});

  TopCourseRevenueResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TopCourseRevenueInfo>[];
      json['data'].forEach((v) {
        data!.add(new TopCourseRevenueInfo.fromJson(v));
      });
    }
  }
  TopCourseRevenueResponseModel.fromJsonList( dynamic json) {
    if (json != null) {
      data = <TopCourseRevenueInfo>[];
      json.forEach((v) {
        data!.add(new TopCourseRevenueInfo.fromJson(v));
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

class TopCourseRevenueInfo {
  int? courseId;
  String? courseName;
  int? totalUser;
  int? totalAmount;
  int? ratePoint;
  int? totalReviews;

  TopCourseRevenueInfo(
      {this.courseId,
        this.courseName,
        this.totalUser,
        this.totalAmount,
        this.ratePoint,
        this.totalReviews});

  TopCourseRevenueInfo.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
    totalUser = json['total_user'];
    totalAmount = json['total_amount'];
    ratePoint = json['rate_point'];
    totalReviews = json['total_reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_id'] = courseId;
    data['course_name'] = courseName;
    data['total_user'] = totalUser;
    data['total_amount'] = totalAmount;
    data['rate_point'] = ratePoint;
    data['total_reviews'] = totalReviews;
    return data;
  }
}
