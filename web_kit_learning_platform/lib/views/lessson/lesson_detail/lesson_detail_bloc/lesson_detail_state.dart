part of 'lesson_detail_bloc.dart';

enum LessonDetailStatus {
  initial,
  onLoading,
  onUpdateWord,
  onUploadDoc,
  onCreateLesson,
  onUpdateLesson,
  onUpdateTestInfo,
  onChangeLesson,
  onAddVideo,
  unKnown
}


@immutable
class LessonDetailState extends Equatable {
  LessonDetailStatus? blocStatus;
  ActionType? lessonActionType;
  LessonInfo? lessonInfo;
  List<VocabularyInfo>?listOfWord;
  List<VocabularyInfo>?listOfWordAdd;
  List<VocabularyInfo>?listOfWordRemove;
  TextEditingController? editingControllerLectureName;
  TextEditingController? editingControllerLectureDescription ;
  TextEditingController? editingControllerLectureContent ;
  TextEditingController? editingControllerLectureVideoLink ;
  TextEditingController? editingControllerLectureDocuments ;
  TestInfo? testInfo;
  ValueNotifier<CategoryInfo?>? valueListenable = ValueNotifier<CategoryInfo?>(null);
  int? videoIndex = 0;

  LessonDetailState({
    this.blocStatus,
    this.lessonActionType,
    this.lessonInfo,
    this.listOfWord,
    this.listOfWordAdd,
    this.listOfWordRemove,
    this.editingControllerLectureDescription,
    this.editingControllerLectureDocuments,
    this.editingControllerLectureContent,
    this.editingControllerLectureName,
    this.editingControllerLectureVideoLink,
    this.testInfo,
    this.valueListenable,
    this.videoIndex
  }){
    listOfWord??=[];
    listOfWordAdd??=[];
    listOfWordRemove??=[];
    editingControllerLectureName??=TextEditingController();
    editingControllerLectureDescription??=TextEditingController();
    editingControllerLectureVideoLink??=TextEditingController();
    editingControllerLectureDocuments??=TextEditingController();
    editingControllerLectureContent??=TextEditingController();
    valueListenable ??= ValueNotifier<CategoryInfo?>(null);
    videoIndex??=0;
  }


  LessonDetailState copyWith({
    LessonDetailStatus? blocStatus,
    ActionType? lessonActionType,
    LessonInfo? lessonInfo,
    List<VocabularyInfo>?listOfWord,
    List<VocabularyInfo>?listOfWordAdd,
    List<VocabularyInfo>?listOfWordRemove,
    TextEditingController? editingControllerLectureName,
    TextEditingController? editingControllerLectureDescription,
    TextEditingController? editingControllerLectureContent,
    TextEditingController? editingControllerLectureVideoLink,
    TextEditingController? editingControllerLectureDocuments,
    TestInfo? testInfo,
    ValueNotifier<CategoryInfo?>? valueListenable,
    int? videoIndex
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
      editingControllerLectureContent: editingControllerLectureContent??this.editingControllerLectureContent,
      editingControllerLectureVideoLink: editingControllerLectureVideoLink??this.editingControllerLectureVideoLink,
      editingControllerLectureDocuments: editingControllerLectureDocuments??this.editingControllerLectureDocuments,
      testInfo: testInfo??this.testInfo,
      valueListenable: valueListenable??this.valueListenable,
      videoIndex: videoIndex??this.videoIndex,


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
    editingControllerLectureContent,
    editingControllerLectureVideoLink,
    editingControllerLectureDocuments,
    testInfo,
    valueListenable,
    videoIndex
  ];

}