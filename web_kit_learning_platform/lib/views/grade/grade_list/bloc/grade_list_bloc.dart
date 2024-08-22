import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/grade/delete_grade_api.dart';
import 'package:webkit/services/apis/grade/get_grade_list.dart';
import 'package:webkit/services/apis/grade/models/grade_info.dart';
import 'package:webkit/services/apis/tags/delete_tag_api.dart';
import 'package:webkit/services/apis/tags/get_tag_list.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';

part 'grade_list_event.dart';

part 'grade_list_state.dart';

class GradeListBloc extends Bloc<GradeListEvent, GradeListState> {
  GradeListBloc(super.initialState) {
    on<GradeListInitEvent>(_onInit);
    on<GradeListOnSearchByFilterEvent>(_onSearchByParams);
    on<GradeListOnDeleteTagEvent>(_onDeleteTag);

    on<TagListOnSelectTagEvent>((event, emit) async {
    });
  }

  Future<void> _onInit(GradeListInitEvent event,
      Emitter<GradeListState> emit,) async {
    emit(state.copyWith(
        blocStatus: GradeListStatus.onLoading,
    ));
    await callTagListApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(GradeListOnSearchByFilterEvent event,
      Emitter<GradeListState> emit,) async {
    emit(state.copyWith(
        blocStatus: GradeListStatus.onLoading,
        searchCommonRequest: event.searchCommonRequest
    ));
    state.contentView= [...(state.tagListResponseModel?.content??[]).where((element) {
      String keyWord = (state.searchCommonRequest?.keyword??"").toLowerCase();
      return (element.name??"").toLowerCase().contains(keyWord);
    },)];
    emit(state.copyWith(
        blocStatus: GradeListStatus.onLoadEnd,
        contentView: state.contentView
    ));  }
  
  Future<void> callTagListApi({required SearchCommonRequest searchCommonRequest}) async {

    GetGradeListApi courseApi = GetGradeListApi();
    GradeListResponseModel responseModel = await courseApi.call();
        emit(state.copyWith(
            tagListResponseModel: responseModel,
            blocStatus: GradeListStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest,
          contentView: responseModel.content
        ));
        if((responseModel.content??[]).isNotEmpty) {
          add(TagListOnSelectTagEvent(selectTagInfo:(responseModel.content??[]).first));       
        }
   

  }

  Future<void> _onDeleteTag(
      GradeListOnDeleteTagEvent event,
      Emitter<GradeListState> emit,) async {

    DeleteGradeApi deleteTagApi = DeleteGradeApi(tagInfo: event.selectTagInfo);
    dynamic data = await deleteTagApi.call();
    if(data.runtimeType!=ResponseCommon)
      {
        add(GradeListInitEvent());
      }
  }
}