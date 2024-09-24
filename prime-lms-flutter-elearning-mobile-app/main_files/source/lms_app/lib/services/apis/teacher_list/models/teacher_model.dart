class TeacherDetailModel {
  List<TeacherDetail>? data;

  TeacherDetailModel({this.data});

  TeacherDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TeacherDetail>[];
      json['data'].forEach((v) {
        data!.add(new TeacherDetail.fromJson(v));
      });
    }
  }
  TeacherDetailModel.fromJsonList(dynamic json) {
    if (json != null) {
      data = <TeacherDetail>[];
      json.forEach((v) {
        data!.add(new TeacherDetail.fromJson(v));
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

class TeacherDetail {
  int? id;
  String? fullName;
  String? userName;
  String? identityId;
  String? gender;
  String? birthday;
  String? phoneNumber;
  int? fileId;
  String? avatar;
  String? countryName;
  String? position;
  String? email;
  String? roleName;
  String? roleId;
  String? bio;
  String? website;
  String? twitter;
  String? facebook;
  String? youtube;
  int? totalStudent;
  int? totalCourse;
  dynamic ratePoint;
  int? totalReview;

  TeacherDetail({
    this.id,
    this.fullName,
    this.userName,
    this.identityId,
    this.gender,
    this.birthday,
    this.phoneNumber,
    this.fileId,
    this.avatar,
    this.countryName,
    this.position,
    this.email,
    this.roleName,
    this.roleId,
    this.bio,
    this.website,
    this.twitter,
    this.facebook,
    this.youtube,
    this.totalStudent,
    this.totalCourse,
    this.ratePoint,
    this.totalReview,
  });

  TeacherDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    userName = json['user_name'];
    identityId = json['identity_id'];
    gender = json['gender'];
    birthday = json['birthday'];
    phoneNumber = json['phone_number'];
    fileId = json['file_id'];
    avatar = json['avatar'];
    countryName = json['country_name'];
    position = json['position'];
    email = json['email'];
    roleName = json['roleName'];
    roleId = json['roleId'];
    bio = json['bio'];
    website = json['website'];
    twitter = json['twitter'];
    facebook = json['facebook'];
    youtube = json['youtube'];
    totalStudent = json['total_student'];
    totalCourse = json['total_course'];
    ratePoint = json['rate_point'];
    totalReview = json['total_review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['user_name'] = userName;
    data['identity_id'] = identityId;
    data['gender'] = gender;
    data['birthday'] = birthday;
    data['phone_number'] = phoneNumber;
    data['file_id'] = fileId;
    data['avatar'] = avatar;
    data['country_name'] = countryName;
    data['position'] = position;
    data['email'] = email;
    data['roleName'] = roleName;
    data['roleId'] = roleId;
    data['bio'] = bio;
    data['website'] = website;
    data['twitter'] = twitter;
    data['facebook'] = facebook;
    data['youtube'] = youtube;
    data['total_student'] = totalStudent;
    data['total_course'] = totalCourse;
    data['rate_point'] = ratePoint;
    data['total_review'] = totalReview;
    return data;
  }
}