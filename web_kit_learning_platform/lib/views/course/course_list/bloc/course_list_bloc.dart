import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/course/course_list/course_api.dart';
import 'package:webkit/services/apis/course/course_list/models/course_models.dart';
import 'package:webkit/services/apis/course/my_course_list/my_course_api.dart';

part 'course_list_event.dart';

part 'course_list_state.dart';

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  CourseListBloc(super.initialState) {
    on<CourseListInitEvent>(_onInit);
    on<CourseListOnSearchByFilterEvent>(_onSearchByParams);
  }

  Future<void> _onInit(CourseListInitEvent event,
      Emitter<CourseListState> emit,) async {
    UserProfile? userProfile = UserManager().getUserProfile();

    emit(state.copyWith(
        blocStatus: CourseStatus.onLoading,
      userProfile: userProfile
    ));
    await callCourseApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(CourseListOnSearchByFilterEvent event,
      Emitter<CourseListState> emit,) async {
    emit(state.copyWith(
        blocStatus: CourseStatus.onLoading,
        searchCommonRequest: event.searchCommonRequest
    ));
    await callCourseApi(searchCommonRequest: event.searchCommonRequest);
  }
  
  Future<void> callCourseApi({required SearchCommonRequest searchCommonRequest}) async {
    if(state.courseType ==CourseType.courseList)
      {
        GetCourseListApi courseApi = GetCourseListApi(searchCommonRequest: state.searchCommonRequest!);
        CourseResponseModel courseResponseModel = await courseApi.call();
        emit(state.copyWith(
            courseResponseModel: courseResponseModel,
            blocStatus: CourseStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest
        ));
      }
    else if(state.courseType ==CourseType.myCourseList)
      {
        MyCourseApi myCourseApi = MyCourseApi(searchCommonRequest: searchCommonRequest);
        CourseResponseModel courseResponseModel = await myCourseApi.call();
        emit(state.copyWith(
            courseResponseModel: courseResponseModel,
            blocStatus: CourseStatus.onLoadEnd,
            searchCommonRequest: searchCommonRequest
        ));
      }
  }
}