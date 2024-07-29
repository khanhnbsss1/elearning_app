
import 'package:get/get.dart';
import 'package:webkit/base/services/base_request/models/page_model.dart';

class CourseResponseModel extends PageModel{
  List<CourseInfo>? content;

  CourseResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  CourseResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <CourseInfo>[];
      json['content'].forEach((v) {
        content!.add(new CourseInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['pageSize'] = pageSize;
    data['pageNumber'] = pageNumber;
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}
class CourseInfo {
  int? id;
  String? name;
  String? image;
  int? totalLectures;
  int? totalSubjects;
  String? producerName;
  String? language;
  String? introduction;
  String? infoObj;
  String? infoResult;
  String? dayFrom;
  String? dayTo;
  int? payment;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  int? ratePoint;
  String? durian;
  String? videoPreview;
  String? courseMode;
  String? gradeName;
  int? categoryId;
  int? isStandard;
  String? categoryName;
  String? typeName;
  int? isActive;
  List<Lectures>? lectures;
  List<Tags>? tags;
  String? accompanyCourse;
  String? mode;
  int? gradeId;

  CourseInfo(
      {this.id,
        this.name,
        this.image,
        this.totalLectures,
        this.totalSubjects,
        this.producerName,
        this.language,
        this.introduction,
        this.infoObj,
        this.infoResult,
        this.dayFrom,
        this.dayTo,
        this.payment,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.ratePoint,
        this.durian,
        this.videoPreview,
        this.courseMode,
        this.gradeName,
        this.categoryId,
        this.isStandard,
        this.categoryName,
        this.typeName,
        this.isActive,
        this.lectures,
        this.tags,
        this.accompanyCourse,
        this.mode,
        this.gradeId
      });

  CourseInfo.initial(){
    id=0;
    name = "";
    image = "";
    totalLectures = 0;
    totalSubjects = 0;
    producerName = "";
    language = "";
    introduction = "";
    infoObj = "";
    infoResult = "";
    dayFrom = "";
    dayTo = "";
    payment = 0;
    createdAt = "";
    updatedAt = "";
    createdBy = "";
    updatedBy = "";
    ratePoint = 0;
    durian = "";
    videoPreview = "";
    courseMode = "";
    gradeName = ("0");
    categoryId = 0;
    isStandard = 0;
    categoryName = "";
    typeName = "";
    isActive = 0;
    accompanyCourse = "0";
    tags = [];
    mode ="public";
    gradeId=0;
  }
  CourseInfo copyWith({
    int? id,
    String? name,
    String? image,
    int? totalLectures,
    int? totalSubjects,
    String? producerName,
    String? language,
    String? introduction,
    String? infoObj,
    String? infoResult,
    String? dayFrom,
    String? dayTo,
    int? payment,
    String? createdAt, 
    String? updatedAt,
    String? createdBy,
    String? updatedBy,
    int? ratePoint,
    String? durian,
    String? videoPreview,
    String? courseMode,
    String? gradeName,
    int? categoryId,
    int? isStandard,
    String? categoryName,
    String? typeName,
    int? isActive,
    List<Lectures>? lectures,
    List<Tags>? tags,
    String? accompanyCourse,
    String? mode,
    int? gradeId
}){
    return CourseInfo(
      id : id??this.id,
      name : name ??this.name,
      image : image ??this.image,
      totalLectures : totalLectures ??this.totalLectures,
      totalSubjects : totalSubjects ??this.totalSubjects,
      producerName : producerName ??this.producerName,
      language : language ??this.language,
      introduction : introduction ??this.introduction,
      infoObj : infoObj ??this.infoObj,
      infoResult : infoResult ??this.infoResult,
      dayFrom : dayFrom ??this.dayFrom,
      dayTo : dayTo ??this.dayTo,
      payment : payment ??this.payment,
      createdAt : createdAt ??this.createdAt,
      updatedAt : updatedAt ??this.updatedAt,
      createdBy : createdBy ??this.createdBy,
      updatedBy : updatedBy ??this.updatedBy,
      ratePoint : ratePoint ??this.ratePoint,
      durian : durian ??this.durian,
      videoPreview : videoPreview ??this.videoPreview,
      courseMode : courseMode ??this.courseMode,
      gradeName : gradeName ??this.gradeName,
      categoryId : categoryId ??this.categoryId,
      isStandard : isStandard ??this.isStandard,
      categoryName : categoryName ??this.categoryName,
      typeName : typeName ??this.typeName,
      isActive : isActive ??this.isActive,
      accompanyCourse : accompanyCourse ??this.accompanyCourse,
      tags : tags ??this.tags,
      lectures:lectures??this.lectures,
      mode:mode??this.mode,
      gradeId:gradeId??this.gradeId,
    );
  
  }
  CourseInfo.copyWithObject(CourseInfo json) {
    id = json.id??id;
    name = json.name??name;
    image = json.image??image;
    totalLectures = json.totalLectures??totalLectures;
    totalSubjects = json.totalSubjects??totalSubjects;
    producerName = json.producerName??producerName;
    language = json.language??language;
    introduction = json.introduction??introduction;
    infoObj = json.infoObj??infoObj;
    infoResult = json.infoResult??infoResult;
    dayFrom = json.dayFrom??dayFrom;
    dayTo = json.dayTo??dayTo;
    payment = json.payment??payment;
    createdAt = json.createdAt??createdAt;
    updatedAt = json.updatedAt??updatedAt;
    createdBy = json.createdBy??createdBy;
    updatedBy = json.updatedBy??updatedBy;
    ratePoint = json.ratePoint??ratePoint;
    durian = json.durian??durian;
    videoPreview = json.videoPreview??videoPreview;
    courseMode = json.courseMode??courseMode;
    gradeName = json.gradeName??gradeName;
    categoryId = json.categoryId??categoryId;
    isStandard =json.isStandard??isStandard;
    categoryName = json.categoryName??categoryName;
    typeName = json.typeName??typeName;
    isActive = json.isActive??isActive;
    accompanyCourse = json.accompanyCourse??accompanyCourse;
    tags = json.tags??tags;
    lectures=json.lectures??lectures;
    mode=json.mode??mode;

  }

  CourseInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    totalLectures = json['total_lectures'];
    totalSubjects = json['total_subjects'];
    producerName = json['producer_name'];
    language = json['language'];
    introduction = json['introduction'];
    infoObj = json['info_obj'];
    infoResult = json['info_result'];
    dayFrom = json['day_from'];
    dayTo = json['day_to'];
    payment = json['payment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    ratePoint = json['rate_point'];
    durian = json['durian'];
    videoPreview = json['video_preview'];
    courseMode = json['course_mode'];
    gradeName = json['grade_name'];
    categoryId = json['category_id'];
    isStandard = json['is_standard'];
    categoryName = json['category_name'];
    typeName = json['type_name'];
    isActive = json['is_active'];
    accompanyCourse = json['accompany_course'];
    mode = json['mode'];
    gradeId = json['grade_id'];
    tags = [];
/*    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags?.add(new Tags.fromJson(v));
      });
    }*/
    lectures=[];
    if (json['lectures'] != null) {
      lectures = <Lectures>[];
      json['lectures'].forEach((v) {
        lectures?.add(new Lectures.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id != 0?id:0;
    data['name'] = name??"";
    data['image'] = image??"";
    data['total_lectures'] = totalLectures??0;
    data['total_subjects'] = totalSubjects??0;
    data['producer_name'] = producerName??"";
    data['language'] = language??"";
    data['introduction'] = introduction??"";
    data['info_obj'] = infoObj??"";
    data['info_result'] = infoResult??"";
    data['day_from'] = dayFrom??"";
    data['day_to'] = dayTo??"";
    data['payment'] = payment??"";
    data['created_at'] = createdAt??"";
    data['updated_at'] = updatedAt??"";
    data['created_by'] = createdBy??"";
    data['updated_by'] = updatedBy??"";
    data['rate_point'] = ratePoint??0;
    data['durian'] = durian??"";
    data['video_preview'] = videoPreview??"";
    data['course_mode'] = courseMode??"";
    data['grade_name'] = gradeName??"";
    data['category_id'] = categoryId??0;
    data['is_standard'] = isStandard??0;
    data['category_name'] = categoryName??"";
    data['type_name'] = typeName??"";
    data['is_active'] = isActive??0;
    data['accompany_course'] = accompanyCourse??"";
    data['mode'] = mode??"FREE";
    data['grade_id'] = gradeId??0;
    
    //data['tags'] = tags;
    if (lectures != null) {
      data['lectures'] = (lectures??[]).map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      String tagsStr = '';
      for(Tags tags in tags??[])
        {
          tagsStr += '${tags.id},'; 
        }
       data['tags'] = tagsStr.replaceFirst(',', '',tagsStr.length-1);
     }
    return data;
  }
}

class Lectures {
  int? id;
  String? subName;
  String? lectureName;
  String? lectureLink;
  String? lectureMode;
  String? document;

  Lectures(
      {this.id,
        this.subName,
        this.lectureName,
        this.lectureLink,
        this.lectureMode,
        this.document
      });

  Lectures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subName = json['sub_name'];
    lectureName = json['lecture_name'];
    lectureLink = json['lecture_link'];
    lectureMode = json['lecture_mode'];
    document = json['document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sub_name'] = subName;
    data['lecture_name'] = lectureName;
    data['lecture_link'] = lectureLink;
    data['lecture_mode'] = lectureMode;
    data['document'] = document;
    return data;
  }
}

class Tags {
  int? id;
  String? name;

  Tags({this.id, this.name});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
  int toJsonString() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data['id'];
  }

  Map<int, String> toMapDropDown() {
    final Map<int, String> data = <int, String>{};
    data[id??0] = name??"";
    return data;
  }
}