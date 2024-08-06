part of 'lesson_detail_bloc.dart';

abstract class LessonDetailEvent extends Equatable {
  const LessonDetailEvent();
  @override
  List<Object?> get props => [];
}

class LessonDetailInitEvent extends LessonDetailEvent {
  LessonDetailInitEvent()
  {
  }
  List<Object?> get props => [];
}