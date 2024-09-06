import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/permission/models/permission_info.dart';
import 'package:webkit/services/apis/permission/permission_list_api.dart';
import 'package:webkit/services/apis/roles/add_permission_api.dart';
import 'package:webkit/services/apis/roles/add_role_api.dart';
import 'package:webkit/services/apis/roles/models/create_role_request_info.dart';
import 'package:webkit/services/apis/roles/models/roles_info.dart';
import 'package:webkit/services/apis/roles/remove_permission_api.dart';
import 'package:webkit/services/apis/roles/update_role_api.dart';
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
            blocStatus: RoleDetailStatus.onUpdateRoleInfo,
      ));
    });
    on<RoleDetailUpdateInfoEvent>((event, emit) async {
      emit(event.state.copyWith(blocStatus: RoleDetailStatus.onUpdateRoleInfo));
    });
  }
  Future<void> _onInit(
      RoleDetailInitEvent event,
      Emitter<RoleDetailState> emit,
      ) async {
    emit(state.copyWith(
      blocStatus: RoleDetailStatus.initial
    ));
  }
  Future<void> _onCreateRole(
      RoleDetailCreateEvent event,
      Emitter<RoleDetailState> emit,
      ) async {     
    MonitorLoading().showLoading("");
      AddRoleApi addRoleApi = AddRoleApi(info: getCreateRoleRequestInfo());
      dynamic data = await addRoleApi.call();
      if(data.runtimeType== String && (data as String).isEmpty)
        {
          emit(state.copyWith(
              blocStatus: RoleDetailStatus.onCreateRole
          ));
        }
      await updatePermissionForRole();
      MonitorLoading().dismiss();

  }
  Future<void> _onUpdateRole(
      RoleDetailUpdateEvent event,
      Emitter<RoleDetailState> emit,
      ) async {
    MonitorLoading().showLoading("");
    UpdateRoleApi addRoleApi = UpdateRoleApi(info:UpdateRoleRequestInfo(roleId: event.state.roleInfo!.id, newRole: event.state.editingControllerRoleName?.text));
    dynamic data = await addRoleApi.call();
   await updatePermissionForRole();
    MonitorLoading().dismiss();
    emit(state.copyWith(
        blocStatus: RoleDetailStatus.onUpdateRole
    ));
  }

  CreateRoleRequestInfo getCreateRoleRequestInfo(){
    CreateRoleRequestInfo createRoleRequestInfo = CreateRoleRequestInfo(roleName: state.editingControllerRoleName?.text);
    return createRoleRequestInfo;
  }
  Future<void> updatePermissionForRole() async {
    List<PermissionInfo>listAdd =[];
    List<PermissionInfo>listRemove =[];
    if(state.roleInfo?.id==null) {
      return;
    }
    for(PermissionGroupInfo permissionGroupInfo in  state.permissionList?.content??[])
    {
      for(PermissionInfo permissionInfo in permissionGroupInfo.permission??[])
      {
        permissionInfo.roleId = state.roleInfo?.id;
        if(permissionInfo.isActivate??false)
        {
          listAdd.add(permissionInfo);
        }
        else
          {
            listRemove.add(permissionInfo);
          }
      }
    }
    

    if(listAdd.isNotEmpty)
      {
        AddPermissionApi addPermissionApi = AddPermissionApi(info: listAdd, roleId: state.roleInfo?.id);
        dynamic dataAdd = await addPermissionApi.call();
      }

    if(listRemove.isNotEmpty)
      {
        RemovePermissionApi removePermissionApi = RemovePermissionApi(info: listRemove, roleId: state.roleInfo!.id!);
        dynamic dataRemove = await removePermissionApi.call();
      }

  }
}
