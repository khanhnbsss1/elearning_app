part of 'login_bloc.dart';

enum LoginStatus {
  unknown,
  initial,
  loginError,
  loginSuccess,
  saveAccount,
}

@immutable
class LoginState extends Equatable {
   LoginStatus? loginStatus;
   UserProfile? currentUserInfo;
   LoginRequest? loginRequest;
   LoginState(
       {
         this.loginStatus,
         this.currentUserInfo,
         this.loginRequest
       });
  LoginState copyWith({
    LoginStatus? loginStatus,
    UserProfile? currentUserInfo,
    LoginRequest? loginRequest
  })
  {
    return LoginState(
      loginStatus: loginStatus??this.loginStatus,
      currentUserInfo: currentUserInfo??this.currentUserInfo,
      loginRequest: loginRequest??this.loginRequest,
    );
  }
  @override
  List<Object?> get props => [
    loginStatus,
    currentUserInfo,
    loginRequest
  ];
}

