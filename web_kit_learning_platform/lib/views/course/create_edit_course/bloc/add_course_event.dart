part of 'add_course_bloc.dart';

abstract class AddCourseEvent extends Equatable {
  const AddCourseEvent();
  @override
  List<Object?> get props => [];
}

class AddCourseInitEvent extends AddCourseEvent {
  AddCourseInitEvent();
  @override
  List<Object?> get props => [];
}
class AddCourseUpdateControllerEvent extends AddCourseEvent {
  AddCourseController addCourseController;
  CourseInfo? courseInfo;
  AddCourseUpdateControllerEvent({required this.addCourseController, this.courseInfo});
  @override
  List<Object?> get props => [addCourseController, courseInfo];
}
class AddCourseSubmitAddEvent extends AddCourseEvent {
  AddCourseSubmitAddEvent({required this.addCourseController});
  AddCourseController addCourseController;
  @override
  List<Object?> get props => [];
}
class AddCourseSubmitUpdateEvent extends AddCourseEvent {
  AddCourseSubmitUpdateEvent({required this.addCourseController});
  AddCourseController addCourseController;
  @override
  List<Object?> get props => [];
}

class AddCourseUploadImageEvent extends AddCourseEvent {
  AddCourseUploadImageEvent({required this.uploadFileInfo});
  UploadFileInfo uploadFileInfo;
  @override
  List<Object?> get props => [uploadFileInfo];
}
class AddCourseUploadVideoPreViewEvent extends AddCourseEvent {
  AddCourseUploadVideoPreViewEvent({required this.uploadFileInfo});
  UploadFileInfo uploadFileInfo;
  @override
  List<Object?> get props => [uploadFileInfo];
}
class AddCourseLinkDiscountEvent extends AddCourseEvent {
  AddCourseLinkDiscountEvent();
  @override
  List<Object?> get props => [];
}

class AddCourseLinkLessonEvent extends AddCourseEvent {
  int courseId;
  int lessonId;
  String subject;
  AddCourseLinkLessonEvent({required this.subject, required this.courseId, required this.lessonId});
  @override
  List<Object?> get props => [subject, courseId, lessonId];
}

class AddCourseUnLinkLessonEvent extends AddCourseEvent {
  int courseId;
  int lessonId;
  String subject;
  AddCourseUnLinkLessonEvent({required this.courseId, required this.lessonId, required this.subject});
  @override
  List<Object?> get props => [courseId, lessonId, subject];
}
class AddCourseUpdateCourseFromApiEvent extends AddCourseEvent {
  AddCourseUpdateCourseFromApiEvent();
  @override
  List<Object?> get props => [];
}
class AddCourseUpdateSubjectListEvent extends AddCourseEvent {
  List<String>subjectList;
  AddCourseUpdateSubjectListEvent({required this.subjectList});
  @override
  List<Object?> get props => [subjectList];
}
class AddCourseUpdateCurrentSubjectEvent extends AddCourseEvent {
  String subject;
  AddCourseUpdateCurrentSubjectEvent({required this.subject});
  @override
  List<Object?> get props => [subject];
}
class AddCourseUpdateCourseInfoEvent extends AddCourseEvent {
  CourseInfo courseInfo;
  AddCourseUpdateCourseInfoEvent({required this.courseInfo});
  @override
  List<Object?> get props => [courseInfo];
}

class AddCourseUpdateTestInfoEvent extends AddCourseEvent {
  TestInfo testInfo;
  AddCourseUpdateTestInfoEvent({required this.testInfo});
  @override
  List<Object?> get props => [testInfo];
}