
import '../../../lessson/models/lesson_info.dart';
import '../../../tags/models/tag_info.dart';
import '../../../topic/model/topic_info.dart';

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
  int? imageId;

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
        this.imageId
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
    isActive = 1;
    accompanyCourse = "0";
    tags = [];
    mode ="public";
    gradeId=0;
    subjects = [];
    imageId=0;
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
    List<Subjects>? subjects,
    int? imageId
  }){
    return CourseInfo(
      id : id??this.id,
      name : name ??this.name,
      image : (image??'').isNotEmpty ? image:this.image,
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
      videoPreview : ((videoPreview??'').isNotEmpty)? videoPreview: this.videoPreview,
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
      imageId:imageId??this.imageId,


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
    imageId=json.imageId??imageId;

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
    accompanyCourse = (json['accompany_course']??'0').toString();
    mode = json['mode'];
    gradeId = json['grade_id'];
    tags = [];
    lectures=[];
    if (json['lectures'] != null) {
      lectures = <LessonInfo>[];
      json['lectures'].forEach((v) {
        lectures?.add(new LessonInfo.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <TagsInfo>[];
      json['tags'].forEach((v) {
        tags?.add(new TagsInfo.fromJson(v));
      });
    }
    subjects = getListSubjectAndLesson();

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id != 0?id:0;
    data['name'] = name??"";
    data['image'] = image??"";
    data['total_lectures'] = totalLectures??0;
    data['total_subjects'] = totalSubjects??0;
    data['producer_name'] = producerName??"";
    if((language??"").isNotEmpty)
    {
      data['language'] = language??"";
    }
    if(imageId!=null)
    {
      data['file_id'] = imageId??0;
    }
    if((introduction??"").isNotEmpty)
    {
      data['introduction'] = introduction??"";
    }
    if((infoObj??"").isNotEmpty)
    {
      data['info_obj'] = infoObj??"";
    }
    if((infoResult??"").isNotEmpty)
    {
      data['info_result'] = infoResult??"";
    }
/*    if((dayFrom??"").isNotEmpty)
    {
      data['day_from'] = dayFrom??"";
    }
    if((dayTo??"").isNotEmpty)
    {
      data['day_to'] = dayTo??"";
    }*/
    if((payment!=null))
    {
      data['payment'] = payment??0;
    }
/*    if((createdAt??"").isNotEmpty)
    {
      data['created_at'] = createdAt??"";
    }
    if((updatedAt??"").isNotEmpty)
    {
      data['updated_at'] = updatedAt??"";
    }*/
    if((createdBy??"").isNotEmpty)
    {
      data['created_by'] = createdBy??"";
    }
    if((updatedBy??"").isNotEmpty)
    {
      data['updated_by'] = updatedBy??"";
    }
    if((ratePoint!=null))
    {
      data['rate_point'] = ratePoint??0;
    }
    data['durian'] = (durian??"").isNotEmpty?(durian??""):'0';

    if((videoPreview??"").isNotEmpty)
    {
      data['video_preview'] = videoPreview??"";
    }
    if((courseMode??"").isNotEmpty)
    {
      data['course_mode'] = courseMode??"";
    }
    if((gradeName??"").isNotEmpty)
    {
      data['grade_name'] = gradeName??"";
    }
    if((categoryId!=null))
    {
      data['category_id'] = categoryId??0;
    }
    if((isStandard!=null))
    {
      data['is_standard'] = isStandard??0;
    }
    if((categoryName??'').isNotEmpty)
    {
      data['category_name'] = categoryName??"";
    }
    if((typeName??'').isNotEmpty)
    {
      data['type_name'] = typeName??"";
    }
    if((isActive!=null))
    {
      data['is_active'] = isActive??"1";
    }
    if((accompanyCourse??'').isNotEmpty)
    {
      data['accompany_course'] = (accompanyCourse??'0');
    }
    if((mode??'').isNotEmpty)
    {
      data['mode'] = mode??"";
    }
    if((gradeId!=null))
    {
      data['grade_id'] = gradeId??0;
    }

    if (tags != null && tags!.isNotEmpty) {
      String tagsStr = '';
      for(TagsInfo tags in tags??[])
      {
        tagsStr += '${tags.id},';
      }
      if(tagsStr.isNotEmpty)
      {
        data['tags'] = tagsStr.replaceFirst(',', '',tagsStr.length-1);
      }
    }
    return data;
  }
  List<String> getListInfoObj(){
    List<String> listInfoObject = (infoObj??"").split("&&&");
    return listInfoObject;
  }
  void setListInfoObj(List<String> listInfoObject){
    infoObj =listInfoObject.join("&&&");
  }
  void insertInfoObject(String infoObject){
    List<String> listInfoObject = getListInfoObj();
    listInfoObject.add(infoObject);
    setListInfoObj(listInfoObject);
  }

  void removeInfoObject(String infoObject){
    List<String> listInfoObject = getListInfoObj();
    listInfoObject.remove(infoObject);
    setListInfoObj(listInfoObject);
  }

  
  List<String> getListInfoResult(){
    List<String> listInfoObject = (infoResult??"").split("&&&");
    return listInfoObject;
  }

  void setListInfoResult(List<String> listInfoResult){
    infoResult =listInfoResult.join("&&&");
  }

  void insertInfoResult(String infoObject){
    List<String> listInfoObject = getListInfoResult();
    listInfoObject.add(infoObject);
    setListInfoResult(listInfoObject);
  }

  void removeInfoResult(String infoObject){
    List<String> listInfoObject = getListInfoResult();
    listInfoObject.remove(infoObject);
    setListInfoResult(listInfoObject);
  }
  
  List<String>getListTagsStr(){
    return (tags??[]).map((e) => (e.name??""),).toList();
  }
  List<Subjects>  getListSubjectAndLesson(){
    List<Subjects>? subjects = [];
    for(LessonInfo lessonInfo in lectures??[]){
      if((subjects).isEmpty)
      {
        subjects.add(Subjects(subName: lessonInfo.subName, lectures: [lessonInfo]));
      }
      else
      {
        int index =0;
        for(index =0; index<(subjects??[]).length; index++){
          if(((subjects).elementAt(index).lectures??[]).first.subName == lessonInfo.subName)
          {
            ((subjects)[index].lectures??[]).add(lessonInfo);
            break;
          }
        }
        if(index == (subjects).length){/// truong hop cua co Subjects cho lecture nay
          subjects.add(Subjects(subName: lessonInfo.subName, lectures: [lessonInfo]));
        }

      }
    }
    return subjects;
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


