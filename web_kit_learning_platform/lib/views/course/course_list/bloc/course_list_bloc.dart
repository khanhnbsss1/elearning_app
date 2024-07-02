import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
part 'course_list_event.dart';
part 'course_list_state.dart';

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  CourseListBloc(super.initialState) {
    on<CourseListInitEvent>(_onInit);
  }
  Future<void> _onInit(
      CourseListInitEvent event,
      Emitter<CourseListState> emit,
      ) async {
    state.blocStatus = CourseListStatus.initial;
  }

}
