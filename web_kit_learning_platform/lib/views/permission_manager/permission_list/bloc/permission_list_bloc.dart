import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

part 'permission_list_event.dart';

part 'permission_list_state.dart';

class PermissionListBloc extends Bloc<PermissionListEvent, PermissionListState> {
  PermissionListBloc(super.initialState) {
    on<PermissionListInitEvent>(_onInit);
    on<PermissionListOnSearchByFilterEvent>(_onSearchByParams);
    on<PermissionListOnDeleteTagEvent>(_onDeletePermission);

    on<PermissionListOnSelectTagEvent>((event, emit) async {
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
    state.contentView= [...(state.tagListResponseModel?.content??[]).where((element) {
      String keyWord = (state.searchCommonRequest?.keyword??"").toLowerCase();
      return (element.type??"").toLowerCase().contains(keyWord) ||
          ((element.permission??[]).where((element) => (element.value??"").toLowerCase().contains(keyWord),).isNotEmpty);
    },)];
    emit(state.copyWith(
        blocStatus: PermissionListStatus.onLoadEnd,
        contentView: state.contentView
    ));  }
  
  Future<void> callPermissionListApi({required SearchCommonRequest searchCommonRequest}) async {

    PermissionListResponseModel? responseModel = await PermissionManager().getPermissionModel();
        emit(state.copyWith(
            tagListResponseModel: responseModel,
            blocStatus: PermissionListStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest,
          contentView: responseModel?.content
        ));
        if((responseModel?.content??[]).isNotEmpty) {
          add(PermissionListOnSelectTagEvent(selectTagInfo:(responseModel?.content??[]).first));       
        }
  }

  Future<void> _onDeletePermission(
      PermissionListOnDeleteTagEvent event,
      Emitter<PermissionListState> emit,) async {
  }
}