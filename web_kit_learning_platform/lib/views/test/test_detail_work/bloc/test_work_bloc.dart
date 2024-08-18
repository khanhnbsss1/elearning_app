import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/test/get_test_detail.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';
part 'test_work_event.dart';
part 'test_work_state.dart';

class TestWorkBloc extends Bloc<TestWorkEvent, TestWorkState> {
  TestWorkBloc(super.initialState) {
    on<TestWorkInitEvent>(_onInit);
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
    emit(state.copyWith(
        blocStatus: TestWorkStatus.initial,testInfo: state.testInfo));
  }
}
