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
class CourseDetailSelectLessonEvent extends CourseDetailEvent {
  LessonInfo selectLessonInfo;
  CourseDetailSelectLessonEvent({required this.selectLessonInfo});
  @override
  List<Object?> get props => [selectLessonInfo];
}

class CourseDetailUpdateInfoSelectLessonEvent extends CourseDetailEvent {
  LessonInfo selectLessonInfo;
  VideoInfo selectVideoInfo;
  CourseDetailUpdateInfoSelectLessonEvent({required this.selectLessonInfo, required this.selectVideoInfo});
  @override
  List<Object?> get props => [selectLessonInfo, selectVideoInfo];
}
class CourseDetailUpdateFinishLessonEvent extends CourseDetailEvent {
  LessonInfo selectLessonInfo;
  VideoInfo selectVideoInfo;
  CourseDetailUpdateFinishLessonEvent({required this.selectLessonInfo, required this.selectVideoInfo});
  @override
  List<Object?> get props => [selectLessonInfo, selectVideoInfo];
}
class CourseDetailOnSelectCurrentVideoEvent extends CourseDetailEvent {
  LessonInfo selectLessonInfo;
  VideoInfo selectVideoInfo;
  CourseDetailOnSelectCurrentVideoEvent({required this.selectLessonInfo, required this.selectVideoInfo});
  @override
  List<Object?> get props => [selectLessonInfo, selectVideoInfo];
}

class CourseDetailOnRatingEvent extends CourseDetailEvent {
  double myRating;
  String comment;
  CourseDetailOnRatingEvent({required this.myRating, required this.comment});
  @override
  List<Object?> get props => [myRating, comment];
}
class CourseDetailOnRemoveRatingEvent extends CourseDetailEvent {
  RatingInfo ratingInfo;
  CourseDetailOnRemoveRatingEvent({required this.ratingInfo});
  @override
  List<Object?> get props => [ratingInfo];
}