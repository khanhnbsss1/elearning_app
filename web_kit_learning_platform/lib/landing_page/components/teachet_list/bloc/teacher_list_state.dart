part of 'teacher_list_bloc.dart';

enum TeacherListStatus {
  initial,
  onLoading
}

@immutable
class TeacherListState extends Equatable {
  TeacherListStatus? blocStatus;
  LandingPageUserListModel? landingPageUserListModel;
  TeacherListState({
      this.blocStatus,
    this.landingPageUserListModel
  });


  TeacherListState copyWith({
    TeacherListStatus? blocStatus,
    LandingPageUserListModel? landingPageUserListModel
  })
  {
    return TeacherListState(
      blocStatus: blocStatus??this.blocStatus,
      landingPageUserListModel: landingPageUserListModel??this.landingPageUserListModel,

    );
  }
  @override
  List<Object?> get props => [blocStatus, landingPageUserListModel];

}