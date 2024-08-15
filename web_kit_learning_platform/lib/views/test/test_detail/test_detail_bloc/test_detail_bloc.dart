import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';

import 'package:webkit/services/apis/question/models/question_info.dart';
import 'package:webkit/services/apis/test/add_test_api.dart';
import 'package:webkit/services/apis/test/get_test_detail.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';
import 'package:webkit/services/apis/test/update_test_api.dart';

part 'test_detail_event.dart';
part 'test_detail_state.dart';

class TestDetailBloc extends Bloc<TestDetailEvent, TestDetailState> {
  TestDetailBloc(super.initialState) {
    on<TestDetailInitEvent>(_onInit);
    on<TestDetailUpdateQuizEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(
          blocStatus: TestDetailStatus.initial,
        listOfWord: event.listOfTest,
        listOfWordRemove: event.listOfTestRemove,
        listOfWordAdd: event.listOfTestAdd
      ));
    });
    on<TestDetailUpdateTestEvent>(_onUpdateTest);
    on<TestDetailCreateTestEvent>(_onCreatedTest);
  }
  Future<void> _onInit(
      TestDetailInitEvent event,
      Emitter<TestDetailState> emit,
      ) async {
    state.blocStatus = TestDetailStatus.initial;
    UserProfile? userProfile = await UserManager().getUserProfile();
    state.testInfo??=TestInfo(createdBy: userProfile?.userName??'');
    if(state.testInfo?.id!=null)
      {
        emit(state.copyWith(
            blocStatus: TestDetailStatus.onLoading,
        ));
        GetTestDetailApi getTestDetailApi = GetTestDetailApi(testId: state.testInfo?.id??0);
        state.testInfo = (await getTestDetailApi.call())?? state.testInfo;
        state.listOfWord = [...state.testInfo?.quizDTOs??[]];
        state.editingControllerTestName?.text = state.testInfo?.lectureName??"";
      }
    emit(state.copyWith(
      blocStatus: TestDetailStatus.initial,
    ));
  }
  Future<void> _onUpdateTest(
      TestDetailUpdateTestEvent event,
      Emitter<TestDetailState> emit,
      ) async {
    state.blocStatus = TestDetailStatus.initial;
    if(state.testInfo?.id!=null)
    {
      MonitorLoading().showLoading("");
      UpdateTestApi getLessonDetailApi = UpdateTestApi(info: event.testInfo);
      dynamic data = await getLessonDetailApi.call();
      if(data.runtimeType==String && (data as String).isEmpty)
      {
        MonitorLoading().dismiss();
        emit(state.copyWith(
            blocStatus: TestDetailStatus.onUpdateLesson,
            testInfo: state.testInfo
        ));
      }
    }

  }
  Future<void> _onCreatedTest(
      TestDetailCreateTestEvent event,
      Emitter<TestDetailState> emit,
      ) async {
    state.blocStatus = TestDetailStatus.initial;
      MonitorLoading().showLoading("");
      AddTestApi getLessonDetailApi = AddTestApi(info: event.testInfo);
      dynamic data = (await getLessonDetailApi.call());
      if(data.runtimeType == int )
        {
          state.testInfo?.id =data;
          emit(state.copyWith(
              blocStatus: TestDetailStatus.onCreateLesson,
              testInfo: state.testInfo
          ));
        }
    MonitorLoading().dismiss();

  }
}

