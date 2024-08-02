part of 'course_detail_bloc.dart';

abstract class CourseDetailEvent extends Equatable {
  const CourseDetailEvent();
  @override
  List<Object?> get props => [];
}

class CourseDetailInitEvent extends CourseDetailEvent {
  CourseDetailInitEvent();
  @override
  List<Object?> get props => [];
}
class AddCourseUpdateControllerEvent extends CourseDetailEvent {
  AddCourseController addCourseController;
  CourseInfo? courseInfo;
  AddCourseUpdateControllerEvent({required this.addCourseController, this.courseInfo});
  @override
  List<Object?> get props => [addCourseController, courseInfo];
}
class AddCourseSubmitAddEvent extends CourseDetailEvent {
  AddCourseSubmitAddEvent({required this.addCourseController});
  AddCourseController addCourseController;
  @override
  List<Object?> get props => [];
}
class AddCourseSubmitUpdateEvent extends CourseDetailEvent {
  AddCourseSubmitUpdateEvent({required this.addCourseController});
  AddCourseController addCourseController;
  @override
  List<Object?> get props => [];
}

class AddCourseUploadImageEvent extends CourseDetailEvent {
  AddCourseUploadImageEvent({required this.uploadFileInfo});
  UploadFileInfo uploadFileInfo;
  @override
  List<Object?> get props => [uploadFileInfo];
}
class AddCourseUploadVideoPreViewEvent extends CourseDetailEvent {
  AddCourseUploadVideoPreViewEvent({required this.uploadFileInfo});
  UploadFileInfo uploadFileInfo;
  @override
  List<Object?> get props => [uploadFileInfo];
}
class AddCourseLinkDiscountEvent extends CourseDetailEvent {
  AddCourseLinkDiscountEvent();
  @override
  List<Object?> get props => [];
}

class AddCourseLinkLessonEvent extends CourseDetailEvent {
  int courseId;
  int lessonId;
  String subject;
  AddCourseLinkLessonEvent({required this.subject, required this.courseId, required this.lessonId});
  @override
  List<Object?> get props => [subject, courseId, lessonId];
}

class AddCourseUnLinkLessonEvent extends CourseDetailEvent {
  int courseId;
  int lessonId;
  String subject;
  AddCourseUnLinkLessonEvent({required this.courseId, required this.lessonId, required this.subject});
  @override
  List<Object?> get props => [courseId, lessonId, subject];
}
class AddCourseUpdateCourseFromApiEvent extends CourseDetailEvent {
  AddCourseUpdateCourseFromApiEvent();
  @override
  List<Object?> get props => [];
}
class AddCourseUpdateSubjectListEvent extends CourseDetailEvent {
  List<String>subjectList;
  AddCourseUpdateSubjectListEvent({required this.subjectList});
  @override
  List<Object?> get props => [subjectList];
}
class AddCourseUpdateCurrentSubjectEvent extends CourseDetailEvent {
  String subject;
  AddCourseUpdateCurrentSubjectEvent({required this.subject});
  @override
  List<Object?> get props => [subject];
}
class AddCourseUpdateCourseInfoEvent extends CourseDetailEvent {
  CourseInfo courseInfo;
  AddCourseUpdateCourseInfoEvent({required this.courseInfo});
  @override
  List<Object?> get props => [courseInfo];
}