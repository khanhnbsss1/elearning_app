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
  onLinkDiscount
}

@immutable
class AddCourseState extends Equatable {
  AddCourseStatus? blocStatus;
  CourseInfo? courseInfo;
  AddCourseController? controller;
  GetAddCourseFilterModel? addCourseFilterModel;
  bool? initial;
  AddCourseState({
    this.blocStatus,
    this.addCourseFilterModel,
    this.initial,
    this.courseInfo,
    this.controller
  }){
    courseInfo??=CourseInfo.initial();
    controller??= Get.put(AddCourseController());
  }


  AddCourseState copyWith({
    AddCourseStatus? blocStatus,
    GetAddCourseFilterModel? addCourseFilterModel,
    bool? initial,
    CourseInfo? courseInfo,
    AddCourseController? controller
  })
  {
    return AddCourseState(
      blocStatus: blocStatus??this.blocStatus,
      addCourseFilterModel: addCourseFilterModel??this.addCourseFilterModel,
      initial: initial??this.initial,
      courseInfo: courseInfo??this.courseInfo,
      controller: controller??this.controller,
    );
  }
  @override
  List<Object?> get props => [blocStatus, addCourseFilterModel, initial, courseInfo, controller];

}

