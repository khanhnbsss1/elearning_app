import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';
import 'package:webkit/services/apis/topic/model/topic_info.dart';

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
  List<LessonInfo>? lectures;
  List<TagsInfo>? tags;
  List<Subjects>? subjects;
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
        this.gradeId,
        this.subjects,
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
    subjects = [];
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
    List<LessonInfo>? lectures,
    List<TagsInfo>? tags,
    String? accompanyCourse,
    String? mode,
    int? gradeId,
    List<Subjects>? subjects
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
      subjects:subjects??this.subjects,

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
    subjects=json.subjects??subjects;

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
    categoryId = int.parse((json['category_id']??'1').toString());
    isStandard = (json['is_standard']??1);
    categoryName = json['category_name'];
    typeName = json['type_name'];
    isActive = json['is_active'];
    accompanyCourse = json['accompany_course'];
    mode = json['mode'];
    gradeId = json['grade_id'];
    subjects = json['subjects'];
    tags = [];
/*    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags?.add(new Tags.fromJson(v));
      });
    }*/
    lectures=[];
    if (json['lectures'] != null) {
      lectures = <LessonInfo>[];
      json['lectures'].forEach((v) {
        lectures?.add(new LessonInfo.fromJson(v));
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
      for(TagsInfo tags in tags??[])
      {
        tagsStr += '${tags.id},';
      }
      data['tags'] = tagsStr.replaceFirst(',', '',tagsStr.length-1);
    }
    return data;
  }
  void addLectureToSubject(){
    for(LessonInfo lessonInfo in lectures??[]){
      if((subjects??[]).isEmpty)
      {
        subjects?.add(Subjects(subName: lessonInfo.subName, lectures: [lessonInfo]));
      }
      else
      {
        int index =0;
        for(index =0; index<(subjects??[]).length; index++){
          if(((subjects??[]).elementAt(index).lectures??[]).first.subName == lessonInfo.subName)
          {
            ((subjects??[])[index].lectures??[]).add(lessonInfo);
            break;
          }
        }
        if(index == (subjects??[]).length){/// truong hop cua co Subjects cho lecture nay
          subjects?.add(Subjects(subName: lessonInfo.subName, lectures: [lessonInfo]));
        }

      }
    }
  }
  List<LessonInfo> convertSubjectToLectureList(){
    List<LessonInfo> lectures = [];
    for(Subjects subjects in subjects??[])
    {
      lectures.addAll(subjects.lectures??[]);
    }
    return lectures;
  }
}


