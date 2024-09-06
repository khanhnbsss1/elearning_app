part of 'user_registration_history_bloc.dart';

abstract class UserRegistrationHistoryListEvent extends Equatable {
  const UserRegistrationHistoryListEvent();
  @override
  List<Object?> get props => [];
}

class UserRegistrationHistoryListInitEvent extends UserRegistrationHistoryListEvent {
  UserRegistrationHistoryListInitEvent();  
  @override
  List<Object?> get props => [];
}
class UserRegistrationHistoryListOnSearchByFilterEvent extends UserRegistrationHistoryListEvent {
  SearchCommonRequest searchCommonRequest;
  UserRegistrationHistoryListOnSearchByFilterEvent({required this.searchCommonRequest} );
  @override
  List<Object?> get props => [searchCommonRequest];
}
class LessonListOnSelectLessonEvent extends UserRegistrationHistoryListEvent {
  LessonInfo selectLessonInfo;
  LessonListOnSelectLessonEvent({required this.selectLessonInfo} );
  @override
  List<Object?> get props => [selectLessonInfo];
}