import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/permission/permisstion.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/roles/get_role_list.dart';
import 'package:webkit/services/apis/roles/models/roles_info.dart';

part 'role_list_event.dart';

part 'role_list_state.dart';

class RoleListBloc extends Bloc<RoleListEvent, RoleListState> {
  RoleListBloc(super.initialState) {
    on<RoleListInitEvent>(_onInit);
    on<RoleListOnSearchByFilterEvent>(_onSearchByParams);
  }

  Future<void> _onInit(RoleListInitEvent event,
      Emitter<RoleListState> emit,) async {
    emit(state.copyWith(
        blocStatus: LessonListStatus.onLoading,
    ));
    await callListApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(RoleListOnSearchByFilterEvent event,
      Emitter<RoleListState> emit,) async {
    emit(state.copyWith(
        blocStatus: LessonListStatus.onLoading,
        searchCommonRequest: event.searchCommonRequest
    ));
    state.contentView= [...(state.roleListResponseModel?.content??[]).where((element) {
      String keyWord = (state.searchCommonRequest?.keyword??"").toLowerCase();
      return (element.name??"").toLowerCase().contains(keyWord);
    },)];
    emit(state.copyWith(
        blocStatus: LessonListStatus.onLoadEnd,
        contentView: state.contentView
    ));
  }
  
  Future<void> callListApi({required SearchCommonRequest searchCommonRequest}) async {

    GetRoleListApi courseApi = GetRoleListApi();
    PermissionManager().rolesListResponseModel = await courseApi.call();
        emit(state.copyWith(
            roleListResponseModel: PermissionManager().rolesListResponseModel,
            blocStatus: LessonListStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest,
            contentView: PermissionManager().rolesListResponseModel?.content
        ));
        if((PermissionManager().rolesListResponseModel?.content??[]).isNotEmpty) {
          add(RoleListOnSelectLessonEvent(roleInfo: (PermissionManager().rolesListResponseModel?.content??[]).first));
        }
   

  }
}