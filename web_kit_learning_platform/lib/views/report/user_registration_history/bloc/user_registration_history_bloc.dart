import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/helper/date_time/date_time_helper.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/darh_board/reports/get_course_registered_history_api.dart';
import 'package:webkit/services/apis/darh_board/reports/get_registered_time_period_api.dart';
import 'package:webkit/services/apis/darh_board/reports/models/course_registed_history_info.dart';
import 'package:webkit/services/apis/darh_board/reports/models/registered_time_period_info.dart';
import 'package:webkit/services/apis/darh_board/reports/models/revenue_history_info.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';


part 'user_registration_history_event.dart';

part 'user_registration_history_state.dart';

class UserRegistrationHistoryListBloc extends Bloc<UserRegistrationHistoryListEvent, UserRegistrationHistoryListState> {
  UserRegistrationHistoryListBloc(super.initialState) {
    on<UserRegistrationHistoryListInitEvent>(_onInit);
    on<UserRegistrationHistoryListOnSearchByFilterEvent>(_onSearchByParams);
  }

  Future<void> _onInit(UserRegistrationHistoryListInitEvent event,
      Emitter<UserRegistrationHistoryListState> emit,) async {
    emit(state.copyWith(
        blocStatus: UserRegistrationHistoryListStatus.onLoading,
    ));
    await callLessonListApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(UserRegistrationHistoryListOnSearchByFilterEvent event,
      Emitter<UserRegistrationHistoryListState> emit,) async {
    emit(state.copyWith(
        blocStatus: UserRegistrationHistoryListStatus.onLoading,
        searchCommonRequest: event.searchCommonRequest
    ));
    await callLessonListApi(searchCommonRequest: event.searchCommonRequest);
  }
  
  Future<void> callLessonListApi({required SearchCommonRequest searchCommonRequest}) async {
    GetRegisterTimePeriodApi courseApi = GetRegisterTimePeriodApi(dashboardSearchModel: state.searchCommonRequest!);
    RegisterTimePeriodResponseModel lessonListResponseModel = await courseApi.call();
    emit(state.copyWith(
            lessonListResponseModel: lessonListResponseModel,
            blocStatus: UserRegistrationHistoryListStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest
    ));
        
  }
}