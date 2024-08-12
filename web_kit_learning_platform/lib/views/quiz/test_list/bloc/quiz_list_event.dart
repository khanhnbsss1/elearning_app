part of 'quiz_list_bloc.dart';

abstract class QuizListEvent extends Equatable {
  const QuizListEvent();
  @override
  List<Object?> get props => [];
}

class QuizListInitEvent extends QuizListEvent {
  QuizListInitEvent();
  @override
  List<Object?> get props => [];
}

class QuizListOnSearchByFilterEvent extends QuizListEvent {
  SearchCommonRequest searchCommonRequest;
  QuizListOnSearchByFilterEvent({required this.searchCommonRequest} );
  @override
  List<Object?> get props => [searchCommonRequest];
}
class QuizListOnSelectTagEvent extends QuizListEvent {
  QuizInfo selectInfo;
  QuizListOnSelectTagEvent({required this.selectInfo} );
  @override
  List<Object?> get props => [selectInfo];
}
class QuizListOnDeleteTagEvent extends QuizListEvent {
  QuizInfo selectInfo;
  QuizListOnDeleteTagEvent({required this.selectInfo} );
  @override
  List<Object?> get props => [selectInfo];
}

