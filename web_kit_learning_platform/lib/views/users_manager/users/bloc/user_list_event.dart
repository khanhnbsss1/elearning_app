part of 'user_list_bloc.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();
  @override
  List<Object?> get props => [];
}

class UserListInitEvent extends UserListEvent {
  UserListInitEvent();  
  @override
  List<Object?> get props => [];
}
class UserListOnSearchByFilterEvent extends UserListEvent {
  SearchCommonRequest searchCommonRequest;
  UserListOnSearchByFilterEvent({required this.searchCommonRequest} );
  @override
  List<Object?> get props => [searchCommonRequest];
}
class UserListOnSelectLessonEvent extends UserListEvent {
  UserProfile userProfile;
  UserListOnSelectLessonEvent({required this.userProfile} );
  @override
  List<Object?> get props => [userProfile];
}