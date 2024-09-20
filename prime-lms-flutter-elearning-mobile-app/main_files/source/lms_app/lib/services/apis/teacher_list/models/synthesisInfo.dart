class SynthesisSummaryInfo {
  int? totalUser;
  int? totalAuthor;
  int? totalEnroll;
  int? totalPurchase;
  int? totalCourse;
  int? totalReview;

  SynthesisSummaryInfo(
      {this.totalUser,
        this.totalAuthor,
        this.totalEnroll,
        this.totalPurchase,
        this.totalCourse,
        this.totalReview});

  SynthesisSummaryInfo.fromJson(Map<String, dynamic> json) {
    totalUser = json['total_user'];
    totalAuthor = json['total_author'];
    totalEnroll = json['total_enroll'];
    totalPurchase = json['total_purchase'];
    totalCourse = json['total_course'];
    totalReview = json['total_review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_user'] = totalUser;
    data['total_author'] = totalAuthor;
    data['total_enroll'] = totalEnroll;
    data['total_purchase'] = totalPurchase;
    data['total_course'] = totalCourse;
    data['total_review'] = totalReview;
    return data;
  }
}
