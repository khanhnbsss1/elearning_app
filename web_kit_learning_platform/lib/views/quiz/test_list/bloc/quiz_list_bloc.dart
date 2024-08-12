import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/quiz/delete_quiz_api.dart';
import 'package:webkit/services/apis/quiz/get_quiz_list_api.dart';
import 'package:webkit/services/apis/quiz/models/quiz_info.dart';

part 'quiz_list_event.dart';
part 'quiz_list_state.dart';

class QuizListBloc extends Bloc<QuizListEvent, QuizListState> {
  QuizListBloc(super.initialState) {
    on<QuizListInitEvent>(_onInit);
    on<QuizListOnSearchByFilterEvent>(_onSearchByParams);
    on<QuizListOnDeleteTagEvent>(_onDeleteQuiz);

    on<QuizListOnSelectTagEvent>((event, emit) async {
    });
  }

  Future<void> _onInit(QuizListInitEvent event,
      Emitter<QuizListState> emit,) async {
    emit(state.copyWith(
      blocStatus: QuizListStatus.onLoading,
    ));
    await callQuizListApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(QuizListOnSearchByFilterEvent event,
      Emitter<QuizListState> emit,) async {
    emit(state.copyWith(
        blocStatus: QuizListStatus.onLoading,
        searchCommonRequest: event.searchCommonRequest
    ));
    await callQuizListApi(searchCommonRequest: event.searchCommonRequest);
  }

  Future<void> callQuizListApi({required SearchCommonRequest searchCommonRequest}) async {

    GetQuizListApi courseApi = GetQuizListApi(searchCommonRequest: state.searchCommonRequest!);
    QuizListResponseModel lessonListResponseModel = await courseApi.call();
    emit(state.copyWith(
        listResponseModel: lessonListResponseModel,
        blocStatus: QuizListStatus.onLoadEnd,
        searchCommonRequest: searchCommonRequest
    ));

  }

  Future<void> _onDeleteQuiz(
      QuizListOnDeleteTagEvent event,
      Emitter<QuizListState> emit,) async {

    DeleteQuizApi deleteTagApi = DeleteQuizApi(info: event.selectInfo);
    dynamic data = await deleteTagApi.call();
    if(data.runtimeType!=ResponseCommon)
    {
      add(QuizListInitEvent());
    }
  }
}

