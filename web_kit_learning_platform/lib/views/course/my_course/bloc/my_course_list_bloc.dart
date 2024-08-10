import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/services/apis/course/course_list/models/course_models.dart';
part 'my_course_list_event.dart';
part 'my_course_list_state.dart';

class MyCourseListBloc extends Bloc<MyCourseListEvent, MyCourseListState> {
  MyCourseListBloc(super.initialState) {
    on<MyCourseListInitEvent>(_onInit);
  }
  Future<void> _onInit(
      MyCourseListInitEvent event,
      Emitter<MyCourseListState> emit,
      ) async {
    emit(state.copyWith(
        blocStatus: MyCourseListStatus.initial
    ));
  }

}
