import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/permission/models/permission_info.dart';
import 'package:webkit/services/apis/permission/permission_list_api.dart';
import 'package:webkit/services/apis/roles/models/roles_info.dart';
part 'role_detail_event.dart';
part 'role_detail_state.dart';

class RoleDetailBloc extends Bloc<RoleDetailEvent, RoleDetailState> {
  RoleDetailBloc(super.initialState) {
    on<RoleDetailInitEvent>(_onInit);
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

}
