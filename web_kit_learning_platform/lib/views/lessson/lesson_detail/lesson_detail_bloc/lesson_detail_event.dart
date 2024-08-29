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
  List<VocabularyInfo>?listOfWordRemove;
  List<VocabularyInfo>?listOfWordAdd;

  LessonDetailUpdateWordsEvent({required this.listOfWord, this.listOfWordAdd, this.listOfWordRemove});
  @override
  List<Object?> get props => [listOfWord, listOfWordAdd, listOfWordRemove];
}
class LessonDetailChangeLessonEvent extends LessonDetailEvent {
  LessonInfo lessonInfo;
  LessonDetailChangeLessonEvent({required this.lessonInfo});
  @override
  List<Object?> get props => [lessonInfo];
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

class LessonDetailUpdateTestInfoEvent extends LessonDetailEvent {
  TestInfo? testInfo;
  LessonDetailUpdateTestInfoEvent({required this.testInfo});
  @override
  List<Object?> get props => [testInfo];
}

class LessonDetailUploadContentDocEvent extends LessonDetailEvent {
  UploadFileInfo docInfo;
  LessonDetailUploadContentDocEvent({required this.docInfo});
  @override
  List<Object?> get props => [docInfo];
}
class LessonDetailOnAddVideoInfoEvent extends LessonDetailEvent {
  LessonDetailOnAddVideoInfoEvent();
  @override
  List<Object?> get props => [];
}
class LessonDetailOnRemoveVideoInfoEvent extends LessonDetailEvent {
  VideoInfo videoInfo;
  LessonDetailOnRemoveVideoInfoEvent({required this.videoInfo});
  @override
  List<Object?> get props => [videoInfo];
}
class LessonDetailOnUpdateVideoInfoEvent extends LessonDetailEvent {
  VideoInfo videoInfo;
  LessonDetailOnUpdateVideoInfoEvent({required this.videoInfo});
  @override
  List<Object?> get props => [videoInfo];
}