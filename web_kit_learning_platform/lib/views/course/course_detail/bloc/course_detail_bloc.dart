import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:webkit/controller/ui/add_course_controller.dart';
import 'package:webkit/services/apis/course/course_detail/get_course_detail_api.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
part 'course_detail_event.dart';
part 'course_detail_state.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  CourseDetailBloc(super.initialState) {
    on<CourseDetailInitEvent>(_onInit);
  }

  Future<void> _onInit(
      CourseDetailInitEvent event,
      Emitter<CourseDetailState> emit,
      ) async {
    emit(state.copyWith(
        blocStatus:  AddCourseStatus.onLoading
    ));
        CourseDetailApi courseDetailApi = CourseDetailApi(courseId: state.courseInfo!.id!);
        CourseInfo courseInfo = await courseDetailApi.call();
        state.courseInfo = courseInfo;
        state.courseResult = state.courseInfo?.getListInfoResult()??[];
        state.courseObject = state.courseInfo?.getListInfoObj()??[];

    emit(state.copyWith(
        blocStatus:  AddCourseStatus.initial,
      courseInfo: state.courseInfo,
      courseObject: state.courseObject,
        courseResult: state.courseResult,
    ));
  }
}

