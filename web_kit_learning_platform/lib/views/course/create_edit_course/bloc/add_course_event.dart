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
  AddCourseUpdateControllerEvent({required this.addCourseController});
  @override
  List<Object?> get props => [];
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
  AddCourseLinkLessonEvent();
  @override
  List<Object?> get props => [];
}