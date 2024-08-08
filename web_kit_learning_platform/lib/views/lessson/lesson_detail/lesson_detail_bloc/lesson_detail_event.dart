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
class LessonDetailUpdateLessonEvent extends LessonDetailEvent {
  LessonInfo lessonInfo;
  LessonDetailUpdateLessonEvent({required this.lessonInfo});
  @override
  List<Object?> get props => [lessonInfo];
}
class LessonDetailCreateLessonEvent extends LessonDetailEvent {
  LessonInfo lessonInfo;
  LessonDetailCreateLessonEvent({required this.lessonInfo});
  @override
  List<Object?> get props => [lessonInfo];
}
class LessonDetailUploadDocumentEvent extends LessonDetailEvent {
  UploadFileInfo docInfo;
  LessonDetailUploadDocumentEvent({required this.docInfo});
  @override
  List<Object?> get props => [docInfo];
}