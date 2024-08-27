part of 'role_detail_bloc.dart';

abstract class RoleDetailEvent extends Equatable {
  const RoleDetailEvent();
  @override
  List<Object?> get props => [];
}

class RoleDetailInitEvent extends RoleDetailEvent {
  RoleDetailInitEvent();
  @override
  List<Object?> get props => [];
}
class RoleDetailChangePermissionEvent extends RoleDetailEvent {
  PermissionListResponseModel permissionListResponseModel;
  RoleDetailChangePermissionEvent({required this.permissionListResponseModel});
  @override
  List<Object?> get props => [permissionListResponseModel];
}

class RoleDetailCreateEvent extends RoleDetailEvent {
  RoleDetailCreateEvent({required this.state});
  RoleDetailState state;
  @override
  List<Object?> get props => [state];
}
class RoleDetailUpdateEvent extends RoleDetailEvent {
  RoleDetailUpdateEvent({required this.state});
  RoleDetailState state;
  @override
  List<Object?> get props => [state];
}