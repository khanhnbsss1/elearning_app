part of 'add_course_directory_bloc.dart';

enum AddCourseFilterStatus {
  onLoading,
  initial,
  onExpand
}

@immutable
class AddCourseFilterState extends Equatable {
  AddCourseFilterStatus? blocStatus;
  AddCourseFilterModel? addCourseFilterModel;
  bool? initial;
  AddCourseFilterState({
    this.blocStatus,
    this.addCourseFilterModel,
    this.initial,
  });


  AddCourseFilterState copyWith({
    AddCourseFilterStatus? blocStatus,
    AddCourseFilterModel? addCourseFilterModel,
    bool? initial,
  })
  {
    return AddCourseFilterState(
      blocStatus: blocStatus??this.blocStatus,
      addCourseFilterModel: addCourseFilterModel??this.addCourseFilterModel,
      initial: initial??this.initial,
    );
  }
  @override
  List<Object?> get props => [blocStatus, addCourseFilterModel, initial];

}

