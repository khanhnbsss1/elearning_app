import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/vocabulary_list_api.dart';

part 'lesson_list_event.dart';

part 'lesson_list_state.dart';

class LessonListBloc extends Bloc<LessonListEvent, LessonListState> {
  LessonListBloc(super.initialState) {
    on<LessonListInitEvent>(_onInit);
    on<LessonListOnSearchByFilterEvent>(_onSearchByParams);
    on<LessonListOnSelectVocabularyEvent>((event, emit) async {
      emit(state.copyWith(
          selectVocabularyInfo: event.selectVocabularyInfo
      ));
    });
  }

  Future<void> _onInit(LessonListInitEvent event,
      Emitter<LessonListState> emit,) async {
    emit(state.copyWith(
        blocStatus: VocabularyStatus.onLoading,
    ));
    await callCourseApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(LessonListOnSearchByFilterEvent event,
      Emitter<LessonListState> emit,) async {
    emit(state.copyWith(
        blocStatus: VocabularyStatus.onLoading,
        searchCommonRequest: event.searchCommonRequest
    ));
    await callCourseApi(searchCommonRequest: event.searchCommonRequest);
  }
  
  Future<void> callCourseApi({required SearchCommonRequest searchCommonRequest}) async {
    if(state.vocabularyType ==VocabularyType.vocabularyList)
      {
        VocabularyApi courseApi = VocabularyApi(searchCommonRequest: state.searchCommonRequest!);
        VocabularyResponseModel vocabularyResponseModel = await courseApi.call();
        emit(state.copyWith(
            vocabularyResponseModel: vocabularyResponseModel,
            blocStatus: VocabularyStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest
        ));
        if((vocabularyResponseModel.content??[]).isNotEmpty) {
          add(LessonListOnSelectVocabularyEvent(selectVocabularyInfo: (vocabularyResponseModel.content??[]).first));
        }
      }
    else if(state.vocabularyType ==VocabularyType.myVocabularyList)
      {
        VocabularyApi myCourseApi = VocabularyApi(searchCommonRequest: searchCommonRequest);
        VocabularyResponseModel vocabularyResponseModel = await myCourseApi.call();
        emit(state.copyWith(
            vocabularyResponseModel: vocabularyResponseModel,
            blocStatus: VocabularyStatus.onLoadEnd,
            searchCommonRequest: searchCommonRequest
        ));
        if((vocabularyResponseModel.content??[]).isNotEmpty) {
          add(LessonListOnSelectVocabularyEvent(selectVocabularyInfo: (vocabularyResponseModel.content??[]).first));
        }
      }
   

  }
}