import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/services/apis/lessson/lesson_detail/get_lesson_detail.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
part 'lesson_detail_event.dart';
part 'lesson_detail_state.dart';

class LessonDetailBloc extends Bloc<LessonDetailEvent, LessonDetailState> {
  LessonDetailBloc(super.initialState) {
    on<LessonDetailInitEvent>(_onInit);
    on<LessonDetailUpdateWordsEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(
          blocStatus: LessonDetailStatus.initial,
        listOfWord: event.listOfWord
      ));
    });
  }
  Future<void> _onInit(
      LessonDetailInitEvent event,
      Emitter<LessonDetailState> emit,
      ) async {
    state.blocStatus = LessonDetailStatus.initial;
    if(state.lessonInfo?.id!=null)
      {
        emit(state.copyWith(
            blocStatus: LessonDetailStatus.onLoading,
        ));
        
        GetLessonDetailApi getLessonDetailApi = GetLessonDetailApi(lessonId: state.lessonInfo?.id??0);
        state.lessonInfo = (await getLessonDetailApi.call())?? state.lessonInfo;
      }
    emit(state.copyWith(
      blocStatus: LessonDetailStatus.initial,
      lessonInfo: state.lessonInfo
    ));
  }

}
