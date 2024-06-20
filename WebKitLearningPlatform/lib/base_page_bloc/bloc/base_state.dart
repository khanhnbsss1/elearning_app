part of 'base_bloc.dart';

enum BaseStatus {
  initial,
}

@immutable
class BaseState extends Equatable {
  BaseStatus? blocStatus;
  BaseState({
      this.blocStatus,});


  BaseState copyWith({
    BaseStatus? blocStatus,
  })
  {
    return BaseState(
      blocStatus: blocStatus??this.blocStatus,
    );
  }
  @override
  List<Object?> get props => [blocStatus];

}