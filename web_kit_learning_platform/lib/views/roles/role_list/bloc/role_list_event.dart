part of 'role_list_bloc.dart';

abstract class RoleListEvent extends Equatable {
  const RoleListEvent();
  @override
  List<Object?> get props => [];
}

class RoleListInitEvent extends RoleListEvent {
  RoleListInitEvent();  
  @override
  List<Object?> get props => [];
}
class RoleListOnSearchByFilterEvent extends RoleListEvent {
  SearchCommonRequest searchCommonRequest;
  RoleListOnSearchByFilterEvent({required this.searchCommonRequest} );
  @override
  List<Object?> get props => [searchCommonRequest];
}
class RoleListOnSelectLessonEvent extends RoleListEvent {
  RoleInfo roleInfo;
  RoleListOnSelectLessonEvent({required this.roleInfo} );
  @override
  List<Object?> get props => [roleInfo];
}