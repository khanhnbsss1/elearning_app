import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';
import 'package:webkit/services/apis/test/get_test_detail.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';
part 'test_work_event.dart';
part 'test_work_state.dart';

class TestWorkBloc extends Bloc<TestWorkEvent, TestWorkState> {
  TestWorkBloc(super.initialState) {
    on<TestWorkInitEvent>(_onInit);
    on<TestWorkOnSubmitResultTestEvent>(_onSubmitTest);
    on<TestWorkOnChangePageTestEvent>((event, emit) {
      emit(state.copyWith(
        blocStatus: TestWorkStatus.onChangePage,
        page: event.page
      ));
    });
  }
  Future<void> _onInit(
      TestWorkInitEvent event,
      Emitter<TestWorkState> emit,
      ) async {
    UserProfile? userProfile = UserManager().getUserProfile();
    emit(state.copyWith(
      blocStatus: TestWorkStatus.onLoading,
    ));
    GetTestDetailApi getTestDetailApi = GetTestDetailApi(testId: state.testInfo?.id??0);
    state.testInfo = (await getTestDetailApi.call())?? state.testInfo;
    state.quizDTOsForView = [];
    int indexList =0;
    (state.quizDTOsForView??[]).add([]);
    for(int index = 0; index< (state.testInfo?.quizDTOs??[]).length; index++)
      {
        if((index!=0 && (index % (state.pageSize!))==0))
          { indexList++;
            (state.quizDTOsForView??[]).add([]);
            (state.quizDTOsForView??[])[indexList].add((state.testInfo?.quizDTOs??[]).elementAt(index));
          }
        else
          {
            (state.quizDTOsForView??[])[indexList].add((state.testInfo?.quizDTOs??[]).elementAt(index));
          }
      }
    emit(state.copyWith(
        blocStatus: TestWorkStatus.initial,
        quizDTOsForView: (state.quizDTOsForView??[]),
        testInfo: state.testInfo));
  }

  Future<void> _onSubmitTest(
      TestWorkOnSubmitResultTestEvent event,
      Emitter<TestWorkState> emit,
      ) async {
    UserProfile? userProfile = UserManager().getUserProfile();
    emit(state.copyWith(
      blocStatus: TestWorkStatus.onLoading,
    ));
    GetTestDetailApi getTestDetailApi = GetTestDetailApi(testId: state.testInfo?.id??0);
    state.testInfo = (await getTestDetailApi.call())?? state.testInfo;
    emit(state.copyWith(
        blocStatus: TestWorkStatus.initial,testInfo: state.testInfo));
  }
}
