part of 'role_detail_bloc.dart';

abstract class RoleDetailEvent extends Equatable {
  const RoleDetailEvent();
  @override
  List<Object?> get props => [];
}

class RoleDetailInitEvent extends RoleDetailEvent {
  RoleDetailInitEvent()
  {
  }
  List<Object?> get props => [];
}