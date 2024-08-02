part of 'course_detail_bloc.dart';

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
  unKnown
}

@immutable
class CourseDetailState extends Equatable {
  AddCourseStatus? blocStatus;
  CourseInfo? courseInfo;
  List<String>? courseObject = [];
  List<String>? courseResult = [];
  CourseDetailState({
    this.blocStatus,
    this.courseInfo,
    this.courseObject,
    this.courseResult

  }){
    courseInfo??=CourseInfo.initial();
  }


  CourseDetailState copyWith({
    AddCourseStatus? blocStatus,
    CourseInfo? courseInfo,
    List<String>? courseObject,
    List<String>? courseResult
  })
  {
    return CourseDetailState(
      blocStatus: blocStatus??this.blocStatus,
         courseInfo: courseInfo??this.courseInfo,
      courseObject: courseObject??this.courseObject,
      courseResult: courseResult??this.courseResult,

    );
  }
  @override
  List<Object?> get props => [
    blocStatus, 
   courseInfo,
    courseObject,
    courseResult
  ];

}

