part of 'question_detail_bloc.dart';

enum QuestionDetailStatus {
  initial,
  onLoading,
  onUpdateFile,
  onUpdateQuestionInfo,
  onUpdateAnswerType,
  onCreateQuestion,
  onUpdateQuestion,
  onAddAnswer,
  onRemoveAnswer,
  onChangeAnswer,
  unKnown
}
@immutable
class QuestionDetailState extends Equatable {
  QuestionDetailStatus? blocStatus;
  ActionType? lessonActionType;
  QuestionInfo? questionInfo;
  Map<int, String>? listOfGradeNames;
  AnswerType? answerType;
  TextEditingController? editingControllerQuestionName;
  TextEditingController? editingControllerQuestionScore ;
  TextEditingController? editingControllerAttackFile ;
  int? answerTempIndex = -1;
  QuestionDetailState({
    this.blocStatus,
    this.lessonActionType,
    this.questionInfo,
    this.editingControllerAttackFile,
    this.editingControllerQuestionName,
    this.editingControllerQuestionScore,
    this.listOfGradeNames,
    this.answerType,
    this.answerTempIndex
  }){
    questionInfo??=QuestionInfo(questionType: QuestionType.text);
    editingControllerQuestionName??=TextEditingController();
    editingControllerAttackFile??=TextEditingController();
    editingControllerQuestionScore??=TextEditingController();
    listOfGradeNames??={};
    answerTempIndex??=-1;
  }


  QuestionDetailState copyWith({
    QuestionDetailStatus? blocStatus,
    ActionType? lessonActionType,
    QuestionInfo? questionInfo,
    
    List<QuestionInfo>?listOfWord,
    List<QuestionInfo>?listOfWordAdd,
    List<QuestionInfo>?listOfWordRemove,
    TextEditingController? editingControllerQuestionName,
    TextEditingController? editingControllerAttackFile,
    TextEditingController? editingControllerQuestionScore,
    Map<int, String>? listOfGradeNames,
    AnswerType? answerType,
    int? answerTempIndex
  })
  {
    return QuestionDetailState(
      blocStatus: blocStatus??this.blocStatus,
      lessonActionType: lessonActionType??this.lessonActionType,
      questionInfo: questionInfo??this.questionInfo,
      editingControllerQuestionName: editingControllerQuestionName??this.editingControllerQuestionName,
      editingControllerQuestionScore: editingControllerQuestionScore??this.editingControllerQuestionScore,
      editingControllerAttackFile: editingControllerAttackFile??this.editingControllerAttackFile,
      listOfGradeNames: listOfGradeNames??this.listOfGradeNames,
      answerType: answerType??this.answerType,
      answerTempIndex: answerTempIndex??this.answerTempIndex,

    );
  }
  @override
  List<Object?> get props => [
    blocStatus,
    lessonActionType,
    questionInfo,
    editingControllerQuestionName,
    editingControllerQuestionScore,
    editingControllerAttackFile,
    listOfGradeNames,
    answerType,
    answerTempIndex
    
  ];

}