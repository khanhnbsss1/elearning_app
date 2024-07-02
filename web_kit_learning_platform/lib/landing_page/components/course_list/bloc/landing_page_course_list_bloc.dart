import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/services/apis/landing_page/course/course_list/course_list_api.dart';
import 'package:webkit/services/apis/landing_page/course/models/course_list_response_model.dart';
part 'landing_page_course_list_event.dart';
part 'landing_page_course_list_state.dart';

class LandingPageCourseListBloc extends Bloc<LandingPageCourseListEvent, LandingPageCourseListState> {
  LandingPageCourseListBloc(super.initialState) {
    on<LandingPageCourseListInitEvent>(_onInit);
    on<LandingPageCourseListOnExpandEvent>((event, emit) {
      emit(state.copyWith(
        blocStatus: CourseListStatus.onExpand,
        isExpand: event.isExpand
      ));
    });
  }
  
  Future<void> _onInit(
      LandingPageCourseListInitEvent event,
      Emitter<LandingPageCourseListState> emit,
      ) async {
    emit(state.copyWith(
        blocStatus:  CourseListStatus.onLoading
    ));
    LandingPageCourseListApi courseListApi = LandingPageCourseListApi();
    CourseListResponseModel courseListLandingPageResponseModel  =await courseListApi.call();
    emit(state.copyWith(
      courseListLandingPageResponseModel: courseListLandingPageResponseModel,
      blocStatus:  CourseListStatus.initial
    ));
  }

}
