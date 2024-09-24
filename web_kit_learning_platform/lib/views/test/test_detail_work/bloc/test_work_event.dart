part of 'test_work_bloc.dart';

abstract class TestWorkEvent extends Equatable {
  const TestWorkEvent();
  @override
  List<Object?> get props => [];
}

class TestWorkInitEvent extends TestWorkEvent {
  TestWorkInitEvent();
  @override
  List<Object?> get props => [];
}
class TestWorkStartTestEvent extends TestWorkEvent {
  TestWorkStartTestEvent();
  @override
  List<Object?> get props => [];
}
class TestWorkOnUpdateChooseQuestionEvent extends TestWorkEvent {
  QuestionInfo questionInfo;
  TestWorkOnUpdateChooseQuestionEvent({required this.questionInfo});
  @override
  List<Object?> get props => [questionInfo];
}

class TestWorkOnSubmitResultTestEvent extends TestWorkEvent {
  TestWorkOnSubmitResultTestEvent();
  @override
  List<Object?> get props => [];
}
class TestWorkOnChangePageTestEvent extends TestWorkEvent {
  int page;
  TestWorkOnChangePageTestEvent({required this.page});
  @override
  List<Object?> get props => [page];
}