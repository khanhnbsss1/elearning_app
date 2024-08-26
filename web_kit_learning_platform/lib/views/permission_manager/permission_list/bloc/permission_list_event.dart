part of 'permission_list_bloc.dart';

abstract class PermissionListEvent extends Equatable {
  const PermissionListEvent();
  @override
  List<Object?> get props => [];
}

class PermissionListInitEvent extends PermissionListEvent {
  PermissionListInitEvent();  
  @override
  List<Object?> get props => [];
}

class PermissionListOnSearchByFilterEvent extends PermissionListEvent {
  SearchCommonRequest searchCommonRequest;
  PermissionListOnSearchByFilterEvent({required this.searchCommonRequest} );
  @override
  List<Object?> get props => [searchCommonRequest];
}
class PermissionListOnSelectTagEvent extends PermissionListEvent {
  PermissionGroupInfo selectTagInfo;
  PermissionListOnSelectTagEvent({required this.selectTagInfo} );
  @override
  List<Object?> get props => [selectTagInfo];
}
class PermissionListOnDeleteTagEvent extends PermissionListEvent {
  PermissionGroupInfo selectTagInfo;
  PermissionListOnDeleteTagEvent({required this.selectTagInfo} );
  @override
  List<Object?> get props => [selectTagInfo];
}
class PermissionListOnUpdatePermissionModelEvent extends PermissionListEvent {
  PermissionListResponseModel? permissionListResponseModel;
  PermissionListOnUpdatePermissionModelEvent({required this.permissionListResponseModel} );
  @override
  List<Object?> get props => [permissionListResponseModel];
}
