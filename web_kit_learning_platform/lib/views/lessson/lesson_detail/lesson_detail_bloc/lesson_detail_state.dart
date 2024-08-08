part of 'lesson_detail_bloc.dart';

enum LessonDetailStatus {
  initial,
  onLoading,
  onUpdateWord,
  onUploadDoc,
  onCreateLesson,
  onUpdateLesson,
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
  List<VocabularyInfo>?listOfWord;
  LessonDetailState({
    this.blocStatus,
    this.lessonActionType,
    this.lessonInfo,
    this.listOfWord
  }){
    listOfWord??=[];
  }


  LessonDetailState copyWith({
    LessonDetailStatus? blocStatus,
    LessonActionType? lessonActionType,
    LessonInfo? lessonInfo,
    List<VocabularyInfo>?listOfWord
  })
  {
    return LessonDetailState(
      blocStatus: blocStatus??this.blocStatus,
      lessonActionType: lessonActionType??this.lessonActionType,
      lessonInfo: lessonInfo??this.lessonInfo,
      listOfWord: listOfWord??this.listOfWord,

    );
  }
  @override
  List<Object?> get props => [blocStatus,lessonActionType,lessonInfo, listOfWord];

}