import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/helper/date_time/date_time_helper.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/darh_board/reports/get_course_registered_history_api.dart';
import 'package:webkit/services/apis/darh_board/reports/models/course_registed_history_info.dart';
import 'package:webkit/services/apis/darh_board/reports/models/revenue_history_info.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';


part 'course_registration_history_event.dart';

part 'course_registration_history_state.dart';

class CourseRegistrationHistoryListBloc extends Bloc<CourseRegistrationHistoryListEvent, CourseRegistrationHistoryListState> {
  CourseRegistrationHistoryListBloc(super.initialState) {
    on<CourseRegistrationHistoryListInitEvent>(_onInit);
    on<CourseRegistrationHistoryListOnSearchByFilterEvent>(_onSearchByParams);
  }

  Future<void> _onInit(CourseRegistrationHistoryListInitEvent event,
      Emitter<CourseRegistrationHistoryListState> emit,) async {
    emit(state.copyWith(
        blocStatus: CourseRegistrationHistoryListStatus.onLoading,
    ));
    await callLessonListApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(CourseRegistrationHistoryListOnSearchByFilterEvent event,
      Emitter<CourseRegistrationHistoryListState> emit,) async {
    emit(state.copyWith(
        blocStatus: CourseRegistrationHistoryListStatus.onLoading,
        searchCommonRequest: event.searchCommonRequest
    ));
    await callLessonListApi(searchCommonRequest: event.searchCommonRequest);
  }
  
  Future<void> callLessonListApi({required SearchCommonRequest searchCommonRequest}) async {
    GetCourseRegisteredHistoryApi courseApi = GetCourseRegisteredHistoryApi(dashboardSearchModel: state.searchCommonRequest!);
    CourseRegisteredHistoryListResponseModel lessonListResponseModel = await courseApi.call();
    emit(state.copyWith(
            lessonListResponseModel: lessonListResponseModel,
            blocStatus: CourseRegistrationHistoryListStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest
    ));
        
  }
}