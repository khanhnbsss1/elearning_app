import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/helper/date_time/date_time_helper.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/payment/get_request_register_list_api.dart';
import 'package:webkit/services/apis/payment/models/request_registered_info.dart';
import 'package:webkit/services/apis/test/delete_test_api.dart';
import 'package:webkit/services/apis/test/get_test_list_api.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';

part 'request_register_list_event.dart';

part 'request_register_list_state.dart';

class RequestRegisterListBloc extends Bloc<RequestRegisterListEvent, RequestRegisterListState> {
  RequestRegisterListBloc(super.initialState) {
    on<RequestRegisterListInitEvent>(_onInit);
    on<RequestRegisterListOnSearchByFilterEvent>(_onSearchByParams);
    on<RequestRegisterListOnDeleteTagEvent>(_onDeleteRequestRegister);

    on<RequestRegisterListOnSelectTestEvent>((event, emit) async {
    });
  }

  Future<void> _onInit(RequestRegisterListInitEvent event,
      Emitter<RequestRegisterListState> emit,) async {
    emit(state.copyWith(
        blocStatus: RequestRegisterListStatus.onLoading,
    ));
    await callRequestRegisterListApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(RequestRegisterListOnSearchByFilterEvent event,
      Emitter<RequestRegisterListState> emit,) async {
    if(event.state!=null)
      {
        emit(event.state!.copyWith(
          blocStatus: RequestRegisterListStatus.onLoading,
          searchCommonRequest: event.searchCommonRequest,
        ));
      }
    else
      {
        emit(state.copyWith(
          blocStatus: RequestRegisterListStatus.onLoading,
          searchCommonRequest: event.searchCommonRequest,
        )); 
      }

    await callRequestRegisterListApi(searchCommonRequest: event.searchCommonRequest);
  }
  
  Future<void> callRequestRegisterListApi({required SearchCommonRequest searchCommonRequest}) async {

    GetRequestRegisteredListApi courseApi = GetRequestRegisteredListApi(searchCommonRequest: state.searchCommonRequest!);
    RequestRegisteredListResponseModel lessonListResponseModel = await courseApi.call();
        emit(state.copyWith(
            listResponseModel: lessonListResponseModel,
            blocStatus: RequestRegisterListStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest
        ));
        
  }

  Future<void> _onDeleteRequestRegister(
      RequestRegisterListOnDeleteTagEvent event,
      Emitter<RequestRegisterListState> emit,) async {

    DeleteTestApi deleteTagApi = DeleteTestApi(info: event.selectInfo);
    dynamic data = await deleteTagApi.call();
    if(data.runtimeType!=ResponseCommon)
      {
        add(RequestRegisterListInitEvent());
      }
  }
}