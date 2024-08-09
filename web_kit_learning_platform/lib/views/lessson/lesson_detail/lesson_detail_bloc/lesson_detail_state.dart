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
  List<VocabularyInfo>?listOfWordAdd;
  List<VocabularyInfo>?listOfWordRemove;

  LessonDetailState({
    this.blocStatus,
    this.lessonActionType,
    this.lessonInfo,
    this.listOfWord,
    this.listOfWordAdd,
    this.listOfWordRemove
  }){
    listOfWord??=[];
    listOfWordAdd??=[];
    listOfWordRemove??=[];
  }


  LessonDetailState copyWith({
    LessonDetailStatus? blocStatus,
    LessonActionType? lessonActionType,
    LessonInfo? lessonInfo,
    List<VocabularyInfo>?listOfWord,
    List<VocabularyInfo>?listOfWordAdd,
    List<VocabularyInfo>?listOfWordRemove
  })
  {
    return LessonDetailState(
      blocStatus: blocStatus??this.blocStatus,
      lessonActionType: lessonActionType??this.lessonActionType,
      lessonInfo: lessonInfo??this.lessonInfo,
      listOfWord: listOfWord??this.listOfWord,
      listOfWordAdd: listOfWordAdd??this.listOfWordAdd,
      listOfWordRemove: listOfWordRemove??this.listOfWordRemove,
    );
  }
  @override
  List<Object?> get props => [blocStatus,lessonActionType,lessonInfo, listOfWord, listOfWordAdd];

}