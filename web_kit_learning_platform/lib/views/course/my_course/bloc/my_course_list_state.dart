part of 'my_course_list_bloc.dart';

enum MyCourseListStatus {
  initial,
}

@immutable
class MyCourseListState extends Equatable {
  MyCourseListStatus? blocStatus;
  MyCourseResponseModel? myCourseResponseModel;

  MyCourseListState({
    this.blocStatus, this.myCourseResponseModel}) {
    myCourseResponseModel ??= MyCourseResponseModel(data: []);
  }


  MyCourseListState copyWith({
    MyCourseListStatus? blocStatus,
    MyCourseResponseModel? myCourseResponseModel,
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