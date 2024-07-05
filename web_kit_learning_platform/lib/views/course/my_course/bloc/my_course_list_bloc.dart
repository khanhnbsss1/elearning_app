import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../services/apis/course/my_course_list/models/my_course_models.dart';
import '../../../../services/apis/course/my_course_list/my_course_api.dart';
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
    MyCourseApi myCourseApi = MyCourseApi();
    MyCourseResponseModel myCourseResponseModel = await myCourseApi.call();
    emit(state.copyWith(
        myCourseResponseModel: myCourseResponseModel,
        blocStatus: MyCourseListStatus.initial
    ));
  }

}
