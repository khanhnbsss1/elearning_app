part of 'my_course_list_bloc.dart';

enum MyCourseListStatus {
  initial,
}

@immutable
class MyCourseListState extends Equatable {
  MyCourseListStatus? blocStatus;
  CourseResponseModel? myCourseResponseModel;

  MyCourseListState({
    this.blocStatus, this.myCourseResponseModel}) {
    myCourseResponseModel ??= CourseResponseModel(content: []);
  }


  MyCourseListState copyWith({
    MyCourseListStatus? blocStatus,
    CourseResponseModel? myCourseResponseModel,
  })
  {
    return MyCourseListState(
      blocStatus: blocStatus??this.blocStatus,
      myCourseResponseModel: myCourseResponseModel??this.myCourseResponseModel,
    );
  }
  @override
  List<Object?> get props => [blocStatus, myCourseResponseModel];

}