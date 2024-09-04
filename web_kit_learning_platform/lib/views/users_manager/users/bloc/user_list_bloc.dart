import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/models/user/UserProfile.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/user/user_manager/user_list_api.dart';

part 'user_list_event.dart';

part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc(super.initialState) {
    on<UserListInitEvent>(_onInit);
    on<UserListOnSearchByFilterEvent>(_onSearchByParams);
  }

  Future<void> _onInit(UserListInitEvent event,
      Emitter<UserListState> emit,) async {
    emit(state.copyWith(
        blocStatus: UserListStatus.onLoading,
    ));
    await callUserListApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(UserListOnSearchByFilterEvent event,
      Emitter<UserListState> emit,) async {
    emit(state.copyWith(
        blocStatus: UserListStatus.onLoading,
        searchCommonRequest: event.searchCommonRequest
    ));
    await callUserListApi(searchCommonRequest: event.searchCommonRequest);
  }
  
  Future<void> callUserListApi({required SearchCommonRequest searchCommonRequest}) async {

    GetUserListApi courseApi = GetUserListApi(searchCommonRequest: state.searchCommonRequest!);
    UserListResponseModel userListResponseModel = await courseApi.call();
        emit(state.copyWith(
            userListResponseModel: userListResponseModel,
            blocStatus: UserListStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest
        ));

  }
}