part of 'add_course_bloc.dart';

enum AddCourseStatus {
  onLoading,
  initial,
  onUpdateController,
  onSubmitAdd,
  onSubmitUpdate, 
  onExpand,
  onUploadImage,
  onUploadVideoPreview,
  onLinkLesson,
  onUnlinkLesson,
  onLinkDiscount,
  onUpdateCourseFromApi,
  onUpdateSubjectList,
  onUpdateCurrentSubject,
  onUpdateTestInfo,
  unKnown
}

@immutable
class AddCourseState extends Equatable {
  AddCourseStatus? blocStatus;
  CourseInfo? courseInfo;
  CoursePageType? coursePageType;
  AddCourseController? controller;
  GetAddCourseFilterModel? addCourseFilterModel;
  bool? initial;
  String? currentSubject;
  List<String>?subjectList;
  List<String>?whoThisCourseIsFor;
  List<String>?whatWillYouAchieveAfterTheCourseStr;
  TestInfo? testInfo;
  AddCourseState({
    this.blocStatus,
    this.addCourseFilterModel,
    this.initial,
    this.courseInfo,
    this.controller,
    this.coursePageType,
    this.currentSubject,
    this.subjectList,
    this.whoThisCourseIsFor,
    this.whatWillYouAchieveAfterTheCourseStr,
    this.testInfo
  }){
    courseInfo??=CourseInfo.initial();
    coursePageType??=CoursePageType.create;
    controller??= Get.put(AddCourseController());
    subjectList??=[];
    whoThisCourseIsFor??=[];
    whatWillYouAchieveAfterTheCourseStr??=[];
  }


  AddCourseState copyWith({
    AddCourseStatus? blocStatus,
    GetAddCourseFilterModel? addCourseFilterModel,
    bool? initial,
    CourseInfo? courseInfo,
    AddCourseController? controller,
    CoursePageType? coursePageType,
    String? currentSubject,
    List<String>?subjectList,
    List<String>?whoThisCourseIsFor,
    List<String>?whatWillYouAchieveAfterTheCourseStr,
    TestInfo? testInfo
  })
  {
    return AddCourseState(
      blocStatus: blocStatus??this.blocStatus,
      addCourseFilterModel: addCourseFilterModel??this.addCourseFilterModel,
      initial: initial??this.initial,
      courseInfo: courseInfo??this.courseInfo,
      controller: controller??this.controller,
      coursePageType: coursePageType??this.coursePageType,
      currentSubject: currentSubject??this.currentSubject,
      subjectList: subjectList??this.subjectList,
      whoThisCourseIsFor: whoThisCourseIsFor??this.whoThisCourseIsFor,
      whatWillYouAchieveAfterTheCourseStr: whatWillYouAchieveAfterTheCourseStr??this.whatWillYouAchieveAfterTheCourseStr,
      testInfo: testInfo??this.testInfo,

    );
  }
  @override
  List<Object?> get props => [
    blocStatus, 
    addCourseFilterModel, 
    initial, courseInfo, 
    controller, coursePageType, 
    currentSubject, subjectList, 
    whoThisCourseIsFor,
    whatWillYouAchieveAfterTheCourseStr,
    testInfo
  ];

}

