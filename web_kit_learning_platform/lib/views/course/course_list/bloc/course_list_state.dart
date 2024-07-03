part of 'course_list_bloc.dart';

enum CourseStatus {
  initial,
  onLoading
}

@immutable
class CourseListState extends Equatable {
  CourseResponseModel? courseResponseModel;
  CourseStatus? blocStatus;
  CourseListState({
      this.blocStatus, this.courseResponseModel,}){
    courseResponseModel??= CourseResponseModel(data: []);
  }


  CourseListState copyWith({
    CourseResponseModel? courseResponseModel,
    CourseStatus? blocStatus,
  })
  {
    return CourseListState(
      blocStatus: blocStatus??this.blocStatus,
      courseResponseModel: courseResponseModel??this.courseResponseModel,
    );
  }
  @override
  List<Object?> get props => [blocStatus, courseResponseModel];

}