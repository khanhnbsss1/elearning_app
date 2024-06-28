import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/services/apis/course/course_list/course_list_api.dart';
import 'package:webkit/services/apis/course/models/course_list_response_model.dart';
part 'course_list_event.dart';
part 'course_list_state.dart';

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  CourseListBloc(super.initialState) {
    on<CourseListInitEvent>(_onInit);
    on<CourseListOnExpandEvent>((event, emit) {
      emit(state.copyWith(
        blocStatus: CourseListStatus.onExpand,
        isExpand: event.isExpand
      ));
    });
  }
  
  Future<void> _onInit(
      CourseListInitEvent event,
      Emitter<CourseListState> emit,
      ) async {
    emit(state.copyWith(
        blocStatus:  CourseListStatus.onLoading
    ));
    LandingPageCourseListApi courseListApi = LandingPageCourseListApi();
    CourseListLandingPageResponseModel courseListLandingPageResponseModel  =await courseListApi.call();
    emit(state.copyWith(
      courseListLandingPageResponseModel: courseListLandingPageResponseModel,
      blocStatus:  CourseListStatus.initial
    ));
  }

}
