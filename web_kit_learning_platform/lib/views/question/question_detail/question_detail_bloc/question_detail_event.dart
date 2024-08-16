part of 'question_detail_bloc.dart';

abstract class QuestionDetailEvent extends Equatable {
  const QuestionDetailEvent();
  @override
  List<Object?> get props => [];
}

class QuestionDetailInitEvent extends QuestionDetailEvent {
  QuestionDetailInitEvent();
  @override
  List<Object?> get props => [];
}
class QuestionDetailUpdateQuizEvent extends QuestionDetailEvent {
  List<QuestionInfo>listOfTest;
  List<QuestionInfo>?listOfTestRemove;
  List<QuestionInfo>?listOfTestAdd;

  QuestionDetailUpdateQuizEvent({required this.listOfTest, this.listOfTestAdd, this.listOfTestRemove});
  @override
  List<Object?> get props => [listOfTest, listOfTestAdd, listOfTestRemove];
}
class QuestionDetailUpdateQuestionEvent extends QuestionDetailEvent {
  QuestionInfo info;
  QuestionDetailUpdateQuestionEvent({required this.info});
  @override
  List<Object?> get props => [info];
}
class QuestionDetailCreateQuestionEvent extends QuestionDetailEvent {
  QuestionInfo info;
  QuestionDetailCreateQuestionEvent({required this.info});
  @override
  List<Object?> get props => [info];
}

class QuestionDetailUpdateQuestionInfoEvent extends QuestionDetailEvent {
  QuestionInfo info;
  QuestionDetailUpdateQuestionInfoEvent({required this.info});
  @override
  List<Object?> get props => [info];
}

class QuestionDetailUpdatAnswerTypeInfoEvent extends QuestionDetailEvent {
  QuestionInfo info;
  QuestionDetailUpdatAnswerTypeInfoEvent({required this.info});
  @override
  List<Object?> get props => [info];
}

class QuestionDetailUpLoadFileInfoEvent extends QuestionDetailEvent {
  UploadFileInfo uploadFileInfo;
  QuestionDetailUpLoadFileInfoEvent({required this.uploadFileInfo});
  @override
  List<Object?> get props => [uploadFileInfo];
}
class QuestionDetailChangeAnswerTypeEvent extends QuestionDetailEvent {
  AnswerType answerType;
  QuestionDetailChangeAnswerTypeEvent({required this.answerType});
  @override
  List<Object?> get props => [answerType];
}

class QuestionDetailAddAnswerInfoEvent extends QuestionDetailEvent {
  QuestionDetailAddAnswerInfoEvent();
  @override
  List<Object?> get props => [];
}
class QuestionDetailRemoveAnswerInfoEvent extends QuestionDetailEvent {
  AnswerInfo answerUploadInfo;
  QuestionDetailRemoveAnswerInfoEvent({required this.answerUploadInfo});
  @override
  List<Object?> get props => [answerUploadInfo];
}
class QuestionDetailChangeAnswerInfoEvent extends QuestionDetailEvent {
  AnswerInfo answerUploadInfo;
  QuestionDetailChangeAnswerInfoEvent({required this.answerUploadInfo});
  @override
  List<Object?> get props => [answerUploadInfo];
}