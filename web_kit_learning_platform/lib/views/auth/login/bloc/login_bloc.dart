import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/auth/login/login_request.dart';
import 'package:webkit/services/apis/auth/login/login_with_phone_api.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserInfo? userInfo;
  LoginBloc() : super(LoginState()) {
    on<LoginInitEvent>(_onInitLoginPage);
    on<LoginSubmittedEvent>(_onLoginSubmitted);
    on<LoginSuccessEvent>((event, emit) => emit(state.copyWith(
        loginStatus: LoginStatus.loginSuccess
    )));
    on<LoginErrorEvent>((event, emit) => emit(state.copyWith(
        loginStatus: LoginStatus.loginError
    )));
  }

  Future<void> _onInitLoginPage(
    LoginInitEvent event,
    Emitter<LoginState> emit,
  ) async {
    List<UserInfo>recentUserInfo = await AuthorManager().getRecentAllUserInfo();
    emit(state.copyWith(
      loginStatus: LoginStatus.initial,
      currentUserInfo: recentUserInfo.last,
    ));
  }

  Future<void> _onLoginSubmitted(LoginSubmittedEvent event, Emitter<LoginState> emit) async {
    MonitorLoading().showLoading("");
    LoginWithPhoneApi loginWithPhoneApi = LoginWithPhoneApi(loginRequest: event.loginRequest);
    bool result = await loginWithPhoneApi.call();
    if(result == true)
      {
        
      }
    else
      {
        
      }
    MonitorLoading().dismiss();
  }
  
}
