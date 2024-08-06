import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
part 'lesson_detail_event.dart';
part 'lesson_detail_state.dart';

class LessonDetailBloc extends Bloc<LessonDetailEvent, LessonDetailState> {
  LessonDetailBloc(super.initialState) {
    on<LessonDetailInitEvent>(_onInit);
  }
  Future<void> _onInit(
      LessonDetailInitEvent event,
      Emitter<LessonDetailState> emit,
      ) async {
    state.blocStatus = LessonDetailStatus.initial;
  }

}
