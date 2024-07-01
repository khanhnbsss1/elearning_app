import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/services/apis/landing_page/teacher_list/models/landing_page_teacher_model.dart';
import 'package:webkit/services/apis/landing_page/teacher_list/teacher_list/get_landing_page_teacher_list_api.dart';
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
    LandingPageTeacherListApi landingPageUserListApi = LandingPageTeacherListApi();
    LandingPageUserListModel landingPageUserListModel= await landingPageUserListApi.call();
    emit(state.copyWith(
      landingPageUserListModel: landingPageUserListModel,
      blocStatus: TeacherListStatus.initial
    ));
  }

}
