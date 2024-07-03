import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/services/apis/landing_page/review/models/landing_page_review_list_response_model.dart';
import 'package:webkit/services/apis/landing_page/review/review_list/review_list_api.dart';
part 'review_list_event.dart';
part 'review_list_state.dart';

class ReviewListBloc extends Bloc<ReviewListEvent, ReviewListState> {
  ReviewListBloc(super.initialState) {
    on<ReviewListInitEvent>(_onInit);
    on<ReviewListOnExpandEvent>((event, emit) {
      emit(state.copyWith(
        blocStatus: ReviewListStatus.onExpand,
        isExpand: event.isExpand
      ));
    });
  }
  
  Future<void> _onInit(
      ReviewListInitEvent event,
      Emitter<ReviewListState> emit,
      ) async {
    emit(state.copyWith(
        blocStatus:  ReviewListStatus.onLoading
    ));
    LandingPageReviewListApi landingPageReviewListApi = LandingPageReviewListApi(typeName: state.typeName );
    ReviewListLandingPageResponseModel reviewListLandingPageResponseModel  =await landingPageReviewListApi.call();
    emit(state.copyWith(
        reviewListLandingPageResponseModel: reviewListLandingPageResponseModel,
      blocStatus:  ReviewListStatus.initial
    ));
  }

}
