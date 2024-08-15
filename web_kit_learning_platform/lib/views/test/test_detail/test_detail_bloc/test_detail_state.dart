part of 'test_detail_bloc.dart';

enum TestDetailStatus {
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
class TestDetailState extends Equatable {
  TestDetailStatus? blocStatus;
  LessonActionType? lessonActionType;
  TestInfo? testInfo;
  List<QuestionInfo>?listOfWord;
  List<QuestionInfo>?listOfWordAdd;
  List<QuestionInfo>?listOfWordRemove;
  TextEditingController? editingControllerTestName;
  TextEditingController? editingControllerTestDescription ;
  TextEditingController? editingControllerTestType ;
  TextEditingController? editingControllerTestTime ;
  TestDetailState({
    this.blocStatus,
    this.lessonActionType,
    this.testInfo,
    this.listOfWord,
    this.listOfWordAdd,
    this.listOfWordRemove,
    this.editingControllerTestDescription,
    this.editingControllerTestTime,
    this.editingControllerTestName,
    this.editingControllerTestType
  }){
    listOfWord??=[];
    listOfWordAdd??=[];
    listOfWordRemove??=[];
    editingControllerTestName??=TextEditingController();
    editingControllerTestDescription??=TextEditingController();
    editingControllerTestType??=TextEditingController();
    editingControllerTestTime??=TextEditingController();

  }


  TestDetailState copyWith({
    TestDetailStatus? blocStatus,
    LessonActionType? lessonActionType,
    TestInfo? testInfo,
    List<QuestionInfo>?listOfWord,
    List<QuestionInfo>?listOfWordAdd,
    List<QuestionInfo>?listOfWordRemove,
    TextEditingController? editingControllerTestName,
    TextEditingController? editingControllerTestDescription,
    TextEditingController? editingControllerTestType,
    TextEditingController? editingControllerTestTime,
  })
  {
    return TestDetailState(
      blocStatus: blocStatus??this.blocStatus,
      lessonActionType: lessonActionType??this.lessonActionType,
      testInfo: testInfo??this.testInfo,
      listOfWord: listOfWord??this.listOfWord,
      listOfWordAdd: listOfWordAdd??this.listOfWordAdd,
      listOfWordRemove: listOfWordRemove??this.listOfWordRemove,
      editingControllerTestName: editingControllerTestName??this.editingControllerTestName,
      editingControllerTestDescription: editingControllerTestDescription??this.editingControllerTestDescription,
      editingControllerTestType: editingControllerTestType??this.editingControllerTestType,
      editingControllerTestTime: editingControllerTestTime??this.editingControllerTestTime,

    );
  }
  @override
  List<Object?> get props => [
    blocStatus,
    lessonActionType,
    testInfo, 
    listOfWord, 
    listOfWordAdd,
    editingControllerTestName,
    editingControllerTestDescription,
    editingControllerTestType,
    editingControllerTestTime
  ];

}