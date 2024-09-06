import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/helper/date_time/date_time_helper.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/darh_board/reports/course_history_api.dart';
import 'package:webkit/services/apis/darh_board/reports/get_revenue_history_api.dart';
import 'package:webkit/services/apis/darh_board/reports/models/revenue_history_info.dart';
import 'package:webkit/services/apis/lessson/lesson_list/lesson_list_api.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';

import '../../../../services/apis/darh_board/reports/models/course_history_info.dart';

part 'course_history_event.dart';

part 'course_history_state.dart';

class CourseHistoryListBloc extends Bloc<CourseHistoryListEvent, CourseHistoryListState> {
  CourseHistoryListBloc(super.initialState) {
    on<CourseHistoryListInitEvent>(_onInit);
    on<CourseHistoryListOnSearchByFilterEvent>(_onSearchByParams);
  }

  Future<void> _onInit(CourseHistoryListInitEvent event,
      Emitter<CourseHistoryListState> emit,) async {
    emit(state.copyWith(
        blocStatus: CourseHistoryListStatus.onLoading,
    ));
    await callLessonListApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(CourseHistoryListOnSearchByFilterEvent event,
      Emitter<CourseHistoryListState> emit,) async {
    emit(state.copyWith(
        blocStatus: CourseHistoryListStatus.onLoading,
        searchCommonRequest: event.searchCommonRequest
    ));
    await callLessonListApi(searchCommonRequest: event.searchCommonRequest);
  }
  
  Future<void> callLessonListApi({required SearchCommonRequest searchCommonRequest}) async {
    GetCourseHistoryApi courseApi = GetCourseHistoryApi(dashboardSearchModel: state.searchCommonRequest!);
    CourseHistoryListResponseModel lessonListResponseModel = await courseApi.call();
    emit(state.copyWith(
            lessonListResponseModel: lessonListResponseModel,
            blocStatus: CourseHistoryListStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest
    ));
        
  }
}