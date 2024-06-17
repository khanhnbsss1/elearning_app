part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class LoginInitEvent extends LoginEvent {
  const LoginInitEvent();
  @override
  List<Object?> get props => [];
}

class LoginSubmittedEvent extends LoginEvent {
  LoginSubmittedEvent({ required this.loginRequest});
  LoginRequest loginRequest;
  @override
  List<Object?> get props => [loginRequest];
}

class LoginSuccessEvent extends LoginEvent {
  const LoginSuccessEvent();
  @override
  List<Object?> get props => [];
}

class LoginErrorEvent extends LoginEvent {
  const LoginErrorEvent();
  @override
  List<Object?> get props => [];
}
