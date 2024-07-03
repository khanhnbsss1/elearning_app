import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/services/apis/course/course_api.dart';
import 'package:webkit/services/apis/course/models/course_models.dart';
import 'package:webkit/services/apis/landing_page/course/models/course_list_landing_page_response_model.dart';

part 'course_list_event.dart';

part 'course_list_state.dart';

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  CourseListBloc(super.initialState) {
    on<CourseListInitEvent>(_onInit);
  }

  Future<void> _onInit(CourseListInitEvent event,
      Emitter<CourseListState> emit,) async {
    CourseApi courseApi = CourseApi();
    CourseResponseModel courseResponseModel = await courseApi.call();
    emit(state.copyWith(
        courseResponseModel: courseResponseModel,
      blocStatus: CourseStatus.initial
    ));
  }
}