import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:webkit/services/apis/course/course_detail/get_course_detail_api.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/lessson/lesson_detail/get_lesson_detail.dart';
import 'package:webkit/services/apis/lessson/lesson_detail/update_study_lesson_proccess.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/topic/model/topic_info.dart';
part 'course_detail_event.dart';
part 'course_detail_state.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  CourseDetailBloc(super.initialState) {
    on<CourseDetailInitEvent>(_onInit);
    on<CourseDetailSelectLessonEvent>((event, emit) async {
      emit(state.copyWith(
        blocStatus: AddCourseStatus.onLoadingSelectLesson,
      ));
      GetLessonDetailApi getLessonDetailApi = GetLessonDetailApi(lessonId: event.selectLessonInfo.id ?? 0);
      state.selectLessonInfo = await getLessonDetailApi.call();
      emit(state.copyWith(blocStatus: AddCourseStatus.onSelectLesson, selectLessonInfo: state.selectLessonInfo));
    });
    on<CourseDetailUpdateInfoSelectLessonEvent>((event, emit) async {
      
      emit(state.copyWith(
          blocStatus: AddCourseStatus.onUpdateSelectionLesson, 
          selectLessonInfo: event.selectLessonInfo));
      
    });
    on<CourseDetailUpdateFinishLessonEvent>(_onFinishLesson);

  }

  Future<void> _onInit(
    CourseDetailInitEvent event,
    Emitter<CourseDetailState> emit,
  ) async {
    emit(state.copyWith(blocStatus: AddCourseStatus.onLoading));
    CourseDetailApi courseDetailApi = CourseDetailApi(courseId: state.courseInfo!.id!);
    CourseInfo courseInfo = await courseDetailApi.call();
    state.courseInfo = courseInfo;
    state.courseResult = state.courseInfo?.getListInfoResult() ?? [];
    state.courseObject = state.courseInfo?.getListInfoObj() ?? [];
    if (courseInfo.getListSubjectAndLesson().isNotEmpty) {
      state.selectLessonInfo = (courseInfo.getListSubjectAndLesson().first.lectures ?? []).first;
      for (Subjects subject in state.courseInfo!.getListSubjectAndLesson()) {
        state.checkLecture?.add(List.filled((subject.lectures ?? []).length, false));
      }
      state.showSubject = List.filled(
        (state.courseInfo!.getListSubjectAndLesson()).length,
        true,
      );
    }
    emit(state.copyWith(
        blocStatus: AddCourseStatus.initial, 
        courseInfo: state.courseInfo, 
        courseObject: state.courseObject, 
        courseResult: state.courseResult, 
        selectLessonInfo: state.selectLessonInfo));
    if(state.selectLessonInfo!=null)
      {
        add(CourseDetailSelectLessonEvent(selectLessonInfo: state.selectLessonInfo!));
      }
  }

  Future<void> _onFinishLesson(
      CourseDetailUpdateFinishLessonEvent event,
      Emitter<CourseDetailState> emit,
      ) async {
    if(state.awaitCallApi ==true) {
      return;
    }
    state.awaitCallApi =true;
    
    int proccess = ((event.selectVideoInfo.order??0) + 1)~/(state.selectLessonInfo?.videoInfos?.link??[]).length;
    UpdateLessonStatusApi updateLessonStatusApi= UpdateLessonStatusApi(
      courseId: state.courseInfo?.id??0, 
      lectureId: state.selectLessonInfo?.id??0,
      progress: proccess * 100
    );
    dynamic data = await updateLessonStatusApi.call();
    
    if((event.selectVideoInfo.order??0)< (state.selectLessonInfo?.videoInfos?.link??[]).length-1)
      {
        /// van con video bai hoc chua hoc tu dong next sang video tiep theo cua bai hoc nay
        state.selectLessonInfo?.selectVideoInfo = (state.selectLessonInfo?.videoInfos?.link??[]).elementAt(event.selectVideoInfo.order=1);
        emit(state.copyWith(
          blocStatus: AddCourseStatus.onUpdateFinishLessonStatus,
          courseInfo: state.courseInfo,
          selectLessonInfo: state.selectLessonInfo
        ));
        
      }
    else
      {
        int indexOfSelectLesson = (state.courseInfo?.lectures??[]).indexWhere((element) => element.id == state.selectLessonInfo?.id,);
        (state.courseInfo?.lectures??[])[indexOfSelectLesson].isFinnish = true;
        emit(state.copyWith(
          blocStatus: AddCourseStatus.onUpdateFinishLessonStatus,
          courseInfo: state.courseInfo,
        ));
        state.awaitCallApi =false;
        if(indexOfSelectLesson<(state.courseInfo?.lectures??[]).length)
        {
          LessonInfo newSelectionLessonInfo  = (state.courseInfo?.lectures??[]).elementAt(indexOfSelectLesson+1);
          add(CourseDetailSelectLessonEvent(selectLessonInfo: newSelectionLessonInfo));
        }
      }

  }
}
