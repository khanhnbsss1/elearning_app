import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/test/delete_test_api.dart';
import 'package:webkit/services/apis/test/get_test_list_api.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';

part 'test_list_event.dart';

part 'test_list_state.dart';

class TestListBloc extends Bloc<TestListEvent, TestListState> {
  TestListBloc(super.initialState) {
    on<TestListInitEvent>(_onInit);
    on<TestListOnSearchByFilterEvent>(_onSearchByParams);
    on<TestListOnDeleteTagEvent>(_onDeleteTest);

    on<TestListOnSelectTagEvent>((event, emit) async {
    });
  }

  Future<void> _onInit(TestListInitEvent event,
      Emitter<TestListState> emit,) async {
    emit(state.copyWith(
        blocStatus: TestListStatus.onLoading,
    ));
    await callTestListApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(TestListOnSearchByFilterEvent event,
      Emitter<TestListState> emit,) async {
    emit(state.copyWith(
        blocStatus: TestListStatus.onLoading,
        searchCommonRequest: event.searchCommonRequest
    ));
    await callTestListApi(searchCommonRequest: event.searchCommonRequest);
  }
  
  Future<void> callTestListApi({required SearchCommonRequest searchCommonRequest}) async {

    GetTestListApi courseApi = GetTestListApi(searchCommonRequest: state.searchCommonRequest!);
    TestListResponseModel lessonListResponseModel = await courseApi.call();
        emit(state.copyWith(
            listResponseModel: lessonListResponseModel,
            blocStatus: TestListStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest
        ));
        
  }

  Future<void> _onDeleteTest(
      TestListOnDeleteTagEvent event,
      Emitter<TestListState> emit,) async {

    DeleteTestApi deleteTagApi = DeleteTestApi(info: event.selectInfo);
    dynamic data = await deleteTagApi.call();
    if(data.runtimeType!=ResponseCommon)
      {
        add(TestListInitEvent());
      }
  }
}