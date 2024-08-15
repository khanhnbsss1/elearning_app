part of 'test_detail_bloc.dart';

abstract class TestDetailEvent extends Equatable {
  const TestDetailEvent();
  @override
  List<Object?> get props => [];
}

class TestDetailInitEvent extends TestDetailEvent {
  TestDetailInitEvent();
  @override
  List<Object?> get props => [];
}
class TestDetailUpdateQuizEvent extends TestDetailEvent {
  List<QuestionInfo>listOfTest;
  List<QuestionInfo>?listOfTestRemove;
  List<QuestionInfo>?listOfTestAdd;

  TestDetailUpdateQuizEvent({required this.listOfTest, this.listOfTestAdd, this.listOfTestRemove});
  @override
  List<Object?> get props => [listOfTest, listOfTestAdd, listOfTestRemove];
}
class TestDetailUpdateTestEvent extends TestDetailEvent {
  TestInfo testInfo;
  TestDetailUpdateTestEvent({required this.testInfo});
  @override
  List<Object?> get props => [testInfo];
}
class TestDetailCreateTestEvent extends TestDetailEvent {
  TestInfo testInfo;
  TestDetailCreateTestEvent({required this.testInfo});
  @override
  List<Object?> get props => [testInfo];
}
