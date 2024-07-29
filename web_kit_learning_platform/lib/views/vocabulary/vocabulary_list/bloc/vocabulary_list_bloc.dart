import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/vocabulary_list_api.dart';

part 'vocabulary_list_event.dart';

part 'vocabulary_list_state.dart';

class VocabularyListBloc extends Bloc<VocabularyListEvent, VocabularyListState> {
  VocabularyListBloc(super.initialState) {
    on<VocabularyListInitEvent>(_onInit);
    on<VocabularyListOnSearchByFilterEvent>(_onSearchByParams);
    on<VocabularyListOnSelectVocabularyEvent>((event, emit) async {
      emit(state.copyWith(
          selectVocabularyInfo: event.selectVocabularyInfo,
        blocStatus: VocabularyStatus.onSelectWord
      ));
    });
  }

  Future<void> _onInit(VocabularyListInitEvent event,
      Emitter<VocabularyListState> emit,) async {
    emit(state.copyWith(
        blocStatus: VocabularyStatus.onLoading,
    ));
    await callCourseApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(VocabularyListOnSearchByFilterEvent event,
      Emitter<VocabularyListState> emit,) async {
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
          add(VocabularyListOnSelectVocabularyEvent(selectVocabularyInfo: (vocabularyResponseModel.content??[]).first));
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
          add(VocabularyListOnSelectVocabularyEvent(selectVocabularyInfo: (vocabularyResponseModel.content??[]).first));
        }
      }
   

  }
}