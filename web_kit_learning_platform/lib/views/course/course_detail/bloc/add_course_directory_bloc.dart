import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:webkit/services/apis/course/add_course_dictionary/add_course_directory_api.dart';
import 'package:webkit/services/apis/course/add_course_dictionary/add_course_directory_model.dart';
part 'add_course_directory_event.dart';
part 'add_course_directory_state.dart';

class AddCourseFilterBloc extends Bloc<AddCourseFilterEvent, AddCourseFilterState> {
  AddCourseFilterBloc(super.initialState) {
    on<AddCourseFilterInitEvent>(_onInit);
  }

  Future<void> _onInit(
      AddCourseFilterInitEvent event,
      Emitter<AddCourseFilterState> emit,
      ) async {
    emit(state.copyWith(
        blocStatus:  AddCourseFilterStatus.onLoading
    ));
    AddCourseFilterApi addCourseFilterApi = AddCourseFilterApi();
    AddCourseFilterModel addCourseFilterModel = await addCourseFilterApi.call();
    emit(state.copyWith(
        addCourseFilterModel: addCourseFilterModel,
        blocStatus:  AddCourseFilterStatus.initial
    ));
  }

}

