import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/permission/permisstion.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/grade/delete_grade_api.dart';
import 'package:webkit/services/apis/grade/get_grade_list.dart';
import 'package:webkit/services/apis/grade/models/grade_info.dart';
import 'package:webkit/services/apis/permission/models/permission_info.dart';
import 'package:webkit/services/apis/permission/permission_list_api.dart';
import 'package:webkit/services/apis/tags/delete_tag_api.dart';
import 'package:webkit/services/apis/tags/get_tag_list.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';
import 'package:webkit/views/permission_manager/permission_list/components/permission_group_list.dart';

part 'permission_list_event.dart';

part 'permission_list_state.dart';

class PermissionListBloc extends Bloc<PermissionListEvent, PermissionListState> {
  PermissionListBloc(super.initialState) {
    on<PermissionListInitEvent>(_onInit);
    on<PermissionListOnSearchByFilterEvent>(_onSearchByParams);
    on<PermissionListOnDeleteTagEvent>(_onDeletePermission);

    on<PermissionListOnSelectTagEvent>((event, emit) async {
    });
    on<PermissionListOnUpdatePermissionModelEvent>((event, emit) async {
      emit(state.copyWith(
        permissionListResponseModel: event.permissionListResponseModel,
        blocStatus: PermissionListStatus.onChangePermission
      ));
    });
  }

  Future<void> _onInit(PermissionListInitEvent event,
      Emitter<PermissionListState> emit,) async {
    emit(state.copyWith(
        blocStatus: PermissionListStatus.onLoading,
    ));
    await callPermissionListApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(PermissionListOnSearchByFilterEvent event,
      Emitter<PermissionListState> emit,) async {
    emit(state.copyWith(
        blocStatus: PermissionListStatus.onLoading,
        searchCommonRequest: event.searchCommonRequest
    ));
    state.contentView= [...(state.permissionListResponseModel?.content??[]).where((element) {
      String keyWord = (state.searchCommonRequest?.keyword??"").toLowerCase();
      String groupName = TiengViet.parse((element.descriptionType??'').toLowerCase());
      String keyWordFinal = TiengViet.parse(keyWord.toLowerCase());
      return groupName.contains(keyWordFinal);
    },)];
    emit(state.copyWith(
        blocStatus: PermissionListStatus.onLoadEnd,
        contentView: state.contentView
    ));  }
  
  Future<void> callPermissionListApi({required SearchCommonRequest searchCommonRequest}) async {
    PermissionListResponseModel? responseModel = await PermissionManager().getPermissionModel(isRefresh: ! (state.enableEdit??false));
    if(state.permissionActionType == PermissionActionType.editChildRole) /// chinh sua quyen cho role con
      {
        /// an het nhung quyen ma role cha bi disable
        for(PermissionGroupInfo permissionGroupInfo in responseModel?.content??[])
          {
            (permissionGroupInfo.permission??[]).removeWhere((element) => element.isActivate==false,);
            if((permissionGroupInfo.permission??[]).isEmpty)
              {
                (responseModel?.content??[]).removeWhere((element) => element.type == permissionGroupInfo.type,);
              }
          }
        
        /// sau do call lay permission hien tai cua role can chinh sua
        if((state.roleId??'').isNotEmpty)
          {
            emit(state.copyWith(
                blocStatus: PermissionListStatus.onLoading,
            ));
            GetPermissionListByRoleApi courseApi = GetPermissionListByRoleApi(roleId: state.roleId);
            PermissionListResponseModel permissionResponseModelChild = await courseApi.call();
            /// set trang thai quyen cua role con cho role cha de lay ra cac quyen cua role con
            
            for(PermissionGroupInfo permissionGroupInfo in responseModel?.content??[])
              {
                if((permissionResponseModelChild.content??[]).where((element) => element.type == permissionGroupInfo.type,).isNotEmpty)
                  {
                    int pemissionIndexChild = (permissionResponseModelChild.content??[]).indexWhere((element) => element.type == permissionGroupInfo.type,);
                    for(PermissionInfo  permissionInfo in permissionGroupInfo.permission??[])
                    {
                      if(((permissionResponseModelChild.content??[])[pemissionIndexChild].permission??[]).where((element) => element.value == permissionInfo.value,).isEmpty)
                        {
                          permissionInfo.isActivate = false;
                          permissionGroupInfo.isActivate=false;
                        }
                    }
                  }
                else
                  {
                    for(PermissionInfo permissionInfo in permissionGroupInfo.permission??[])
                      {
                        permissionInfo.isActivate= false; /// set tat ca cac quyen cua nhom do ve false
                        permissionGroupInfo.isActivate=false;
                      }
                  }
              }
            
          }
      }
        emit(state.copyWith(
            permissionListResponseModel: responseModel,
            blocStatus: PermissionListStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest,
          contentView: responseModel?.content
        ));
  }

  Future<void> _onDeletePermission(
      PermissionListOnDeleteTagEvent event,
      Emitter<PermissionListState> emit,) async {
  }
}