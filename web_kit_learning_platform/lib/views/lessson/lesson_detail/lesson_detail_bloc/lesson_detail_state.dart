part of 'lesson_detail_bloc.dart';

enum LessonDetailStatus {
  initial,
  unKnown
}

enum LessonActionType{
  view,
  create,
  edit,
  delete
}
@immutable
class LessonDetailState extends Equatable {
  LessonDetailStatus? blocStatus;
  LessonActionType? lessonActionType;
  LessonInfo? lessonInfo;
  LessonDetailState({
      this.blocStatus,
    this.lessonActionType,
    this.lessonInfo
  });


  LessonDetailState copyWith({
    LessonDetailStatus? blocStatus,
    LessonActionType? lessonActionType,
    LessonInfo? lessonInfo
  })
  {
    return LessonDetailState(
      blocStatus: blocStatus??this.blocStatus,
      lessonActionType: lessonActionType??this.lessonActionType,
      lessonInfo: lessonInfo??this.lessonInfo,

    );
  }
  @override
  List<Object?> get props => [blocStatus,lessonActionType,lessonInfo];

}