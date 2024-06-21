part of 'base_bloc.dart';

abstract class BaseEvent extends Equatable {
  const BaseEvent();
  @override
  List<Object?> get props => [];
}

class BaseInitEvent extends BaseEvent {
  BaseInitEvent()
  {
  }
  List<Object?> get props => [];
}