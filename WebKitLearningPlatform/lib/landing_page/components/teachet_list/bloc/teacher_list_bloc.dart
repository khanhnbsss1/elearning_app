import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
part 'teacher_list_event.dart';
part 'teacher_list_state.dart';

class TeacherListBloc extends Bloc<TeacherListEvent, TeacherListState> {
  TeacherListBloc(super.initialState) {
    on<TeacherListInitEvent>(_onInit);
  }
  Future<void> _onInit(
      TeacherListInitEvent event,
      Emitter<TeacherListState> emit,
      ) async {
    state.blocStatus = TeacherListStatus.initial;
  }

}
