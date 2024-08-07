part of 'lesson_detail_bloc.dart';

abstract class LessonDetailEvent extends Equatable {
  const LessonDetailEvent();
  @override
  List<Object?> get props => [];
}

class LessonDetailInitEvent extends LessonDetailEvent {
  LessonDetailInitEvent();
  @override
  List<Object?> get props => [];
}
class LessonDetailUpdateWordsEvent extends LessonDetailEvent {
  List<VocabularyInfo>listOfWord;
  LessonDetailUpdateWordsEvent({required this.listOfWord});
  @override
  List<Object?> get props => [listOfWord];
}
