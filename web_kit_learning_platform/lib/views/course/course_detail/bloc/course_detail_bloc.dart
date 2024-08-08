import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/ui/add_course_controller.dart';
import 'package:webkit/services/apis/course/course_detail/get_course_detail_api.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/lessson/lesson_detail/get_lesson_detail.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/topic/model/topic_info.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
part 'course_detail_event.dart';
part 'course_detail_state.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  CourseDetailBloc(super.initialState) {
    on<CourseDetailInitEvent>(_onInit);
    on<CourseDetailSelectLessonEvent>((event, emit) async {
      MonitorLoading().showLoading('');
      GetLessonDetailApi getLessonDetailApi = GetLessonDetailApi(lessonId: event.selectLessonInfo.id??0);
      state.selectLessonInfo = await getLessonDetailApi.call();
      MonitorLoading().dismiss();
      emit(state.copyWith(
        blocStatus: AddCourseStatus.onSelectLesson,
        selectLessonInfo: state.selectLessonInfo
      ));
    });
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
        if(courseInfo.getListSubjectAndLesson().isNotEmpty) {
          state.selectLessonInfo= (courseInfo.getListSubjectAndLesson().first.lectures??[]).first;
          for (Subjects subject in state.courseInfo!.getListSubjectAndLesson()) {
            state.checkLecture?.add(List.filled((subject.lectures ?? []).length, false));
          }
          state.showSubject = List.filled((state.courseInfo!.getListSubjectAndLesson()).length, false,);
        }
    
        
    emit(state.copyWith(
        blocStatus:  AddCourseStatus.initial,
      courseInfo: state.courseInfo,
      courseObject: state.courseObject,
        courseResult: state.courseResult,
      selectLessonInfo: state.selectLessonInfo
    ));
  }
}

