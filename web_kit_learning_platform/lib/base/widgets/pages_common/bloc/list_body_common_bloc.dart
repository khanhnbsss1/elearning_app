
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
part 'list_body_common_event.dart';
part 'list_body_common_state.dart';

class ListBodyCommonBloc extends Bloc<ListBodyCommonEvent, ListBodyCommonState> {
  ListBodyCommonBloc(super.initialState) {

    on<ListBodyCommonInitEvent>((event, emit) {
      emit(state.copyWith(
          blocStatus: ListBodyCommonStatus.initial,
      ));
    });

    on<ListBodyCommonDragEvent>((event, emit) {
      double ratioDrag = (event.dx ?? 0) / state.widthOfPage!;
      state.widthOfListRatio = state.widthOfListRatio! + ratioDrag;
      if (state.widthOfListRatio! >= state.maxOfWidthOfListRatio!) {
        state.widthOfListRatio = state.maxOfWidthOfListRatio!;
      }
      if (state.widthOfListRatio! <= state.minOfWidthOfListRatio!) {
        state.widthOfListRatio = state.minOfWidthOfListRatio!;
      }
      emit(state.copyWith(
        blocStatus: ListBodyCommonStatus.onDrag,
        widthOfListRatio:  state.widthOfListRatio,
      ));
    });
  }
}
