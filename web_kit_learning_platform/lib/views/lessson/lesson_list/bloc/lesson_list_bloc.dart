import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/lessson/lesson_list/lesson_list_api.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';

part 'lesson_list_event.dart';

part 'lesson_list_state.dart';

class LessonListBloc extends Bloc<LessonListEvent, LessonListState> {
  LessonListBloc(super.initialState) {
    on<LessonListInitEvent>(_onInit);
    on<LessonListOnSearchByFilterEvent>(_onSearchByParams);
    on<LessonListOnSelectLessonEvent>((event, emit) async {
      emit(state.copyWith(
          selectLessonInfo: event.selectLessonInfo,
        blocStatus: LessonListStatus.onSelectLesson
      ));
    });
  }

  Future<void> _onInit(LessonListInitEvent event,
      Emitter<LessonListState> emit,) async {
    emit(state.copyWith(
        blocStatus: LessonListStatus.onLoading,
    ));
    await callLessonListApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(LessonListOnSearchByFilterEvent event,
      Emitter<LessonListState> emit,) async {
    emit(state.copyWith(
        blocStatus: LessonListStatus.onLoading,
        searchCommonRequest: event.searchCommonRequest
    ));
    await callLessonListApi(searchCommonRequest: event.searchCommonRequest);
  }
  
  Future<void> callLessonListApi({required SearchCommonRequest searchCommonRequest}) async {

    GetLessonListApi courseApi = GetLessonListApi(searchCommonRequest: state.searchCommonRequest!);
    LessonListResponseModel lessonListResponseModel = await courseApi.call();
        emit(state.copyWith(
            lessonListResponseModel: lessonListResponseModel,
            blocStatus: LessonListStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest
        ));
        if((lessonListResponseModel.content??[]).isNotEmpty) {
          add(LessonListOnSelectLessonEvent(selectLessonInfo: (lessonListResponseModel.content??[]).first));
        }
   

  }
}