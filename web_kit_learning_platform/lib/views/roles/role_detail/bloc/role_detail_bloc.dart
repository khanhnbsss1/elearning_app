import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/permission/models/permission_info.dart';
import 'package:webkit/services/apis/permission/permission_list_api.dart';
import 'package:webkit/services/apis/roles/add_role_api.dart';
import 'package:webkit/services/apis/roles/models/create_role_request_info.dart';
import 'package:webkit/services/apis/roles/models/roles_info.dart';
part 'role_detail_event.dart';
part 'role_detail_state.dart';

class RoleDetailBloc extends Bloc<RoleDetailEvent, RoleDetailState> {
  RoleDetailBloc(super.initialState) {
    on<RoleDetailInitEvent>(_onInit);
    on<RoleDetailCreateEvent>(_onCreateRole);
    on<RoleDetailUpdateEvent>(_onUpdateRole);
    on<RoleDetailChangePermissionEvent>((event, emit) async {
      emit(state.copyWith(
        permissionList: event.permissionListResponseModel,
            blocStatus: RoleDetailStatus.onChangePermission
      ));
    });
  }
  Future<void> _onInit(
      RoleDetailInitEvent event,
      Emitter<RoleDetailState> emit,
      ) async {
    if(state.roleInfo?.id!=null)
      {
        GetPermissionListByRoleApi permissionListApi = GetPermissionListByRoleApi(roleId: state.roleInfo?.id);
        state.permissionList = await permissionListApi.call();
      }
    emit(state.copyWith(
      permissionList: state.permissionList,
      blocStatus: RoleDetailStatus.initial
    ));
  }
  Future<void> _onCreateRole(
      RoleDetailCreateEvent event,
      Emitter<RoleDetailState> emit,
      ) async {
     // emit(event.state);
      
      AddRoleApi addRoleApi = AddRoleApi(info: getCreateRoleRequestInfo());
      dynamic data = await addRoleApi.call();
      if(data.runtimeType== String && (data as String).isEmpty)
        {
          emit(state.copyWith(
              permissionList: state.permissionList,
              blocStatus: RoleDetailStatus.onCreateRole
          ));
        }

  }
  Future<void> _onUpdateRole(
      RoleDetailUpdateEvent event,
      Emitter<RoleDetailState> emit,
      ) async {
    //emit(event.state);
    
    AddRoleApi addRoleApi = AddRoleApi(info: getCreateRoleRequestInfo());
    dynamic data = await addRoleApi.call();
    emit(state.copyWith(
        permissionList: state.permissionList,
        blocStatus: RoleDetailStatus.onUpdateRole
    ));
  }

  CreateRoleRequestInfo getCreateRoleRequestInfo(){
    CreateRoleRequestInfo createRoleRequestInfo = CreateRoleRequestInfo(roleName: state.editingControllerRoleName?.text, claims: []);
    for(PermissionGroupInfo permissionGroupInfo in  state.permissionList?.content??[])
    {
      for(PermissionInfo permissionInfo in permissionGroupInfo.permission??[])
      {
        if(permissionInfo.isActivate??false)
        {
          createRoleRequestInfo.claims?.add(Claims(type: permissionGroupInfo.type, value: permissionInfo.value));
        }
      }
    }
    return createRoleRequestInfo;
  }
}
