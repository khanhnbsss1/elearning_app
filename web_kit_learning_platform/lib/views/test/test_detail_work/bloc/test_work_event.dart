part of 'test_work_bloc.dart';

abstract class TestWorkEvent extends Equatable {
  const TestWorkEvent();
  @override
  List<Object?> get props => [];
}

class TestWorkInitEvent extends TestWorkEvent {
  TestWorkInitEvent()
  {
  }
  List<Object?> get props => [];
}