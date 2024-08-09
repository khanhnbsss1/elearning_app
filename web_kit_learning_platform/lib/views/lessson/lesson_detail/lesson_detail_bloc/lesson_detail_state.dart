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
  TextEditingController? editingControllerLectureName;
  TextEditingController? editingControllerLectureDescription ;
  TextEditingController? editingControllerLectureVideoLink ;
  TextEditingController? editingControllerLectureDocuments ;
  LessonDetailState({
    this.blocStatus,
    this.lessonActionType,
    this.lessonInfo,
    this.listOfWord,
    this.listOfWordAdd,
    this.listOfWordRemove,
    this.editingControllerLectureDescription,
    this.editingControllerLectureDocuments,
    this.editingControllerLectureName,
    this.editingControllerLectureVideoLink
  }){
    listOfWord??=[];
    listOfWordAdd??=[];
    listOfWordRemove??=[];
    editingControllerLectureName??=TextEditingController();
    editingControllerLectureDescription??=TextEditingController();
    editingControllerLectureVideoLink??=TextEditingController();
    editingControllerLectureDocuments??=TextEditingController();

  }


  LessonDetailState copyWith({
    LessonDetailStatus? blocStatus,
    LessonActionType? lessonActionType,
    LessonInfo? lessonInfo,
    List<VocabularyInfo>?listOfWord,
    List<VocabularyInfo>?listOfWordAdd,
    List<VocabularyInfo>?listOfWordRemove,
    TextEditingController? editingControllerLectureName,
    TextEditingController? editingControllerLectureDescription,
    TextEditingController? editingControllerLectureVideoLink,
    TextEditingController? editingControllerLectureDocuments,
  })
  {
    return LessonDetailState(
      blocStatus: blocStatus??this.blocStatus,
      lessonActionType: lessonActionType??this.lessonActionType,
      lessonInfo: lessonInfo??this.lessonInfo,
      listOfWord: listOfWord??this.listOfWord,
      listOfWordAdd: listOfWordAdd??this.listOfWordAdd,
      listOfWordRemove: listOfWordRemove??this.listOfWordRemove,
      editingControllerLectureName: editingControllerLectureName??this.editingControllerLectureName,
      editingControllerLectureDescription: editingControllerLectureDescription??this.editingControllerLectureDescription,
      editingControllerLectureVideoLink: editingControllerLectureVideoLink??this.editingControllerLectureVideoLink,
      editingControllerLectureDocuments: editingControllerLectureDocuments??this.editingControllerLectureDocuments,

    );
  }
  @override
  List<Object?> get props => [
    blocStatus,
    lessonActionType,
    lessonInfo, 
    listOfWord, 
    listOfWordAdd,
    editingControllerLectureName,
    editingControllerLectureDescription,
    editingControllerLectureVideoLink,
    editingControllerLectureDocuments
  ];

}