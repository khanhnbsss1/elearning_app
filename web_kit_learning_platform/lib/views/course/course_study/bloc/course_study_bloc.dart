import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:webkit/services/apis/course/course_detail/get_course_detail_api.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';


part 'course_study_event.dart';
part 'course_study_state.dart';

class CourseStudyBloc extends Bloc<CourseStudyEvent, CourseStudyState> {
  CourseStudyBloc(super.initialState) {
    on<CourseStudyInitEvent>(_onInit);
  }

  Future<void> _onInit(
      CourseStudyInitEvent event,
      Emitter<CourseStudyState> emit,
      ) async {
    CourseDetailApi courseDetailApi = CourseDetailApi(courseId: state.courseInfo!.id!);
    CourseInfo courseInfo= await courseDetailApi.call();
    emit(state.copyWith(
        courseInfo: courseInfo,
        blocStatus: CourseStudyStatus.initial
    ));
  }
}

