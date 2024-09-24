import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/course/course_list/models/course_models.dart';
import 'package:webkit/services/apis/darh_board/reports/get_course_list_by_register_user_api.dart';
import 'package:webkit/services/apis/darh_board/reports/models/revenue_history_info.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
part 'course_list_by_registed_user_event.dart';

part 'course_list_by_registed_user_state.dart';

class CourseListByRegistedUserBloc extends Bloc<CourseListByRegistedUserEvent, CourseListByRegistedUserState> {
  CourseListByRegistedUserBloc(super.initialState) {
    on<CourseListByRegistedUserInitEvent>(_onInit);
    on<CourseListByRegistedUserOnSearchByFilterEvent>(_onSearchByParams);
  }

  Future<void> _onInit(CourseListByRegistedUserInitEvent event,
      Emitter<CourseListByRegistedUserState> emit,) async {
    emit(state.copyWith(
        blocStatus: CourseListByRegistedUserStatus.onLoading,
    ));
    await callListApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(CourseListByRegistedUserOnSearchByFilterEvent event,
      Emitter<CourseListByRegistedUserState> emit,) async {
    emit(state.copyWith(
        blocStatus: CourseListByRegistedUserStatus.onLoading,
        searchCommonRequest: event.searchCommonRequest
    ));
    await callListApi(searchCommonRequest: event.searchCommonRequest);
  }
  
  Future<void> callListApi({required SearchCommonRequest searchCommonRequest}) async {
    GetCourseListByRegistedUserApi courseApi = GetCourseListByRegistedUserApi(dashboardSearchModel: state.searchCommonRequest!);
    CourseResponseModel lessonListResponseModel = await courseApi.call();
    emit(state.copyWith(
            courseResponseModel: lessonListResponseModel,
            blocStatus: CourseListByRegistedUserStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest
    ));
        
  }
}