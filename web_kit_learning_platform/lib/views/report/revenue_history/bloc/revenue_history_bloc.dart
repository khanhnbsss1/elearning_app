import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/darh_board/reports/get_course_registered_history_api.dart';
import 'package:webkit/services/apis/darh_board/reports/get_revenue_history_api.dart';
import 'package:webkit/services/apis/darh_board/reports/models/revenue_history_info.dart';
import 'package:webkit/services/apis/lessson/lesson_list/lesson_list_api.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';

part 'revenue_history_event.dart';

part 'revenue_history_state.dart';

class RevenueHistoryListBloc extends Bloc<RevenueHistoryListEvent, RevenueHistoryListState> {
  RevenueHistoryListBloc(super.initialState) {
    on<RevenueHistoryListInitEvent>(_onInit);
    on<RevenueHistoryListOnSearchByFilterEvent>(_onSearchByParams);
  }

  Future<void> _onInit(RevenueHistoryListInitEvent event,
      Emitter<RevenueHistoryListState> emit,) async {
    emit(state.copyWith(
        blocStatus: RevenueHistoryListStatus.onLoading,
    ));
    await callLessonListApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(RevenueHistoryListOnSearchByFilterEvent event,
      Emitter<RevenueHistoryListState> emit,) async {
    emit(state.copyWith(
        blocStatus: RevenueHistoryListStatus.onLoading,
        searchCommonRequest: event.searchCommonRequest
    ));
    await callLessonListApi(searchCommonRequest: event.searchCommonRequest);
  }
  
  Future<void> callLessonListApi({required SearchCommonRequest searchCommonRequest}) async {

    GetRevenueHistoryApi courseApi = GetRevenueHistoryApi(dashboardSearchModel: state.searchCommonRequest!);
    RevenueHistoryListResponseModel lessonListResponseModel = await courseApi.call();
    emit(state.copyWith(
            lessonListResponseModel: lessonListResponseModel,
            blocStatus: RevenueHistoryListStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest
    ));
        
  }
}