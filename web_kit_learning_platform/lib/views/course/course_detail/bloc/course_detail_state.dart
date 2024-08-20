part of 'course_detail_bloc.dart';

enum AddCourseStatus {
  onLoading,
  initial,
  onLoadingSelectLesson,
  onSelectLesson,
  onUpdateSelectionLesson,
  onUpdateFinishLessonStatus,
  unKnown
}

@immutable
class CourseDetailState extends Equatable {
  AddCourseStatus? blocStatus;
  CourseInfo? courseInfo;
  List<String>? courseObject = [];
  List<String>? courseResult = [];
  LessonInfo? selectLessonInfo;
  List<bool>? showSubject = [];
  List<List<bool>>?checkLecture = [];
  bool? awaitCallApi;
  CourseDetailState({
    this.blocStatus,
    this.courseInfo,
    this.courseObject,
    this.courseResult,
    this.selectLessonInfo,
    this.checkLecture,
    this.showSubject,
    this.awaitCallApi

  }){
    courseInfo??=CourseInfo.initial();
    checkLecture??=[];
    showSubject??=[];
    awaitCallApi??=false;
  }


  CourseDetailState copyWith({
    AddCourseStatus? blocStatus,
    CourseInfo? courseInfo,
    List<String>? courseObject,
    List<String>? courseResult,
    LessonInfo? selectLessonInfo, 
    List<bool>? showSubject, 
    List<List<bool>>?checkLecture 
  })
  {
    return CourseDetailState(
      blocStatus: blocStatus??this.blocStatus,
         courseInfo: courseInfo??this.courseInfo,
      courseObject: courseObject??this.courseObject,
      courseResult: courseResult??this.courseResult,
      selectLessonInfo: selectLessonInfo??this.selectLessonInfo,
      showSubject: showSubject??this.showSubject,
      checkLecture: checkLecture??this.checkLecture,

    );
  }
  @override
  List<Object?> get props => [
    blocStatus, 
    courseInfo,
    courseObject,
    courseResult,
    selectLessonInfo,
    showSubject,
    checkLecture
  ];

}

