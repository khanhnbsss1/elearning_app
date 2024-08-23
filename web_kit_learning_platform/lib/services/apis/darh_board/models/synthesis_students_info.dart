class SynthesisStudentInfoResponseModel {
  List<SynthesisStudentInfo>? data;

  SynthesisStudentInfoResponseModel({this.data});

  SynthesisStudentInfoResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SynthesisStudentInfo>[];
      json['data'].forEach((v) {
        data!.add(new SynthesisStudentInfo.fromJson(v));
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

class SynthesisStudentInfo {
  int? studentId;
  int? totalCourse;

  SynthesisStudentInfo({this.studentId, this.totalCourse});

  SynthesisStudentInfo.fromJson(Map<String, dynamic> json) {
    studentId = json['sudent_id'];
    totalCourse = json['total_course'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sudent_id'] = studentId;
    data['total_course'] = totalCourse;
    return data;
  }
}
