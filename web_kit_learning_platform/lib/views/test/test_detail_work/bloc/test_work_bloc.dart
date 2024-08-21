import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';
import 'package:webkit/services/apis/scores/create_score_api.dart';
import 'package:webkit/services/apis/scores/models/score_info.dart';
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
    on<TestWorkOnUpdateChooseQuestionEvent>(_onUpdateChoosesQuestion);
  }
  Future<void> _onInit(
      TestWorkInitEvent event,
      Emitter<TestWorkState> emit,
      ) async {
    UserProfile? userProfile = UserManager().getUserProfile();
    emit(state.copyWith(
      blocStatus: TestWorkStatus.onLoading,
    ));
    MonitorLoading().showLoading("");
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
    MonitorLoading().dismiss();
    emit(state.copyWith(
        blocStatus: TestWorkStatus.initial,
        quizDTOsForView: (state.quizDTOsForView??[]),
        testInfo: state.testInfo));
  }

  Future<void> _onSubmitTest(
      TestWorkOnSubmitResultTestEvent event,
      Emitter<TestWorkState> emit,
      ) async {
    emit(state.copyWith(
      blocStatus: TestWorkStatus.onLoading,
    ));
    MonitorLoading().showLoading("");
    ScoresInfo info = ScoresInfo(testId: state.testInfo?.id??0);
    for(QuestionInfo questionInfo in state.testInfo?.quizDTOs??[])
      {
        ScoreItem scoreItem = ScoreItem(
            questionId: questionInfo.id,
            answerId: questionInfo.answerIdChoose, 
            answerText: questionInfo.answerChoose);
        info.scores?.add(scoreItem);
      }
    CreateScoreApi createScoreApi = CreateScoreApi(info: info);
    dynamic result = await createScoreApi.call();
    
    MonitorLoading().dismiss();
    emit(state.copyWith(
        blocStatus: TestWorkStatus.initial,testInfo: state.testInfo));
  }

  Future<void> _onUpdateChoosesQuestion(
      TestWorkOnUpdateChooseQuestionEvent event,
      Emitter<TestWorkState> emit,
      ) async {
    
    int questionIndex = (state.testInfo?.quizDTOs??[]).indexWhere((element) => element.id == event.questionInfo.id,);
    (state.testInfo?.quizDTOs??[])[questionIndex] = event.questionInfo;
    emit(state.copyWith(
        blocStatus: TestWorkStatus.onUpdateChooseQuestion,
        testInfo: state.testInfo,
      
    ));
  }
}
