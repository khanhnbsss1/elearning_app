class CourseDetail {
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
  String? categoryId;
  int? isStandard;
  String? categoryName;
  String? typeName;
  int? isActive;
  List<LecturesInfo>? lectures;
  List<TagsInfo>? tags;
  List<Subjects>? subjects;
  CourseDetail(
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
        this.subjects,
        this.tags});

  CourseDetail.fromJson(Map<String, dynamic> json) {
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
    subjects = [];
    if (json['lectures'] != null) {
      lectures = <LecturesInfo>[];
      json['lectures'].forEach((v) {
        lectures!.add(new LecturesInfo.fromJson(v));
      });
      addLectureToSubject();
    }

    if (json['tags'] != null) {
      tags = <TagsInfo>[];
      json['tags'].forEach((v) {
        tags!.add(new TagsInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['total_lectures'] = totalLectures;
    data['total_subjects'] = totalSubjects;
    data['producer_name'] = producerName;
    data['language'] = language;
    data['introduction'] = introduction;
    data['info_obj'] = infoObj;
    data['info_result'] = infoResult;
    data['day_from'] = dayFrom;
    data['day_to'] = dayTo;
    data['payment'] = payment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['rate_point'] = ratePoint;
    data['durian'] = durian;
    data['video_preview'] = videoPreview;
    data['course_mode'] = courseMode;
    data['grade_name'] = gradeName;
    data['category_id'] = categoryId;
    data['is_standard'] = isStandard;
    data['category_name'] = categoryName;
    data['type_name'] = typeName;
    data['is_active'] = isActive;
    lectures = convertSubjectToLectureList();
    if (lectures != null) {
      data['lectures'] = lectures!.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  void addLectureToSubject(){
    for(LecturesInfo lecturesInfo in lectures??[]){
      if((subjects??[]).isEmpty)
      {
        subjects?.add(Subjects(subName: lecturesInfo.subName, lectures: [lecturesInfo]));
      }
      else
      {
        int index =0;
        for(index =0; index<(subjects??[]).length; index++){
          if(((subjects??[]).elementAt(index).lectures??[]).first.subName == lecturesInfo.subName)
          {
            ((subjects??[])[index].lectures??[]).add(lecturesInfo);
            break;
          }
        }
        if(index == (subjects??[]).length){/// truong hop cua co Subjects cho lecture nay
          subjects?.add(Subjects(subName: lecturesInfo.subName, lectures: [lecturesInfo]));
        }

      }
    }
  }
  List<LecturesInfo> convertSubjectToLectureList(){
    List<LecturesInfo> lectures = [];
    for(Subjects subjects in subjects??[])
    {
      lectures.addAll(subjects.lectures??[]);
    }
    return lectures;
  }
}
class Subjects {
  String? subName;
  List<LecturesInfo>? lectures;
  Subjects({this.subName, this.lectures}){
    lectures??=[];
  }
  Subjects.fromJson(Map<String, dynamic> json) {
    subName = json['sub_name'];
    if (json['lectures'] != null) {
      lectures = <LecturesInfo>[];
      json['lectures'].forEach((v) {
        lectures!.add(new LecturesInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_name'] = subName;
    if (lectures != null) {
      data['lectures'] = lectures!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class LecturesInfo {
  int? id;
  String? subName;
  int? courseId;
  String? lectureName;
  String? link;
  String? mode;
  String? note;
  String? createdBy;

  LecturesInfo(
      {this.id,
        this.subName,
        this.courseId,
        this.lectureName,
        this.link,
        this.mode,
        this.note,
        this.createdBy});

  LecturesInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subName = json['sub_name'];
    courseId = json['course_id'];
    lectureName = json['lecture_name'];
    link = json['link'];
    mode = json['mode'];
    note = json['note'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sub_name'] = subName;
    data['course_id'] = courseId;
    data['lecture_name'] = lectureName;
    data['link'] = link;
    data['mode'] = mode;
    data['note'] = note;
    data['created_by'] = createdBy;
    return data;
  }
}

class TagsInfo {
  int? id;
  String? name;

  TagsInfo({this.id, this.name});

  TagsInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
