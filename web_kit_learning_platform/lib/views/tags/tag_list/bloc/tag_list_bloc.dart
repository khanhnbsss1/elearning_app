import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/tags/delete_tag_api.dart';
import 'package:webkit/services/apis/tags/get_tag_list.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';

part 'tag_list_event.dart';

part 'tag_list_state.dart';

class TagListBloc extends Bloc<TagListEvent, TagListState> {
  TagListBloc(super.initialState) {
    on<TagListInitEvent>(_onInit);
    on<TagListOnSearchByFilterEvent>(_onSearchByParams);
    on<TagListOnDeleteTagEvent>(_onDeleteTag);

    on<TagListOnSelectTagEvent>((event, emit) async {
    });
  }

  Future<void> _onInit(TagListInitEvent event,
      Emitter<TagListState> emit,) async {
    emit(state.copyWith(
        blocStatus: TagListStatus.onLoading,
    ));
    await callTagListApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(TagListOnSearchByFilterEvent event,
      Emitter<TagListState> emit,) async {

    emit(state.copyWith(
        blocStatus: TagListStatus.onLoading,
        searchCommonRequest: event.searchCommonRequest
    ));
    state.contentView= [...(state.tagListResponseModel?.content??[]).where((element) {
      String keyWord = (state.searchCommonRequest?.keyword??"").toLowerCase();
      return (element.name??"").toLowerCase().contains(keyWord);
    },)];
    emit(state.copyWith(
        blocStatus: TagListStatus.onLoadEnd,
        contentView: state.contentView
    ));
  }
  
  Future<void> callTagListApi({required SearchCommonRequest searchCommonRequest}) async {

    GetTagListApi courseApi = GetTagListApi(searchCommonRequest: state.searchCommonRequest!);
    TagListResponseModel lessonListResponseModel = await courseApi.call();
    
        emit(state.copyWith(
            tagListResponseModel: lessonListResponseModel,
            blocStatus: TagListStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest,
          contentView: lessonListResponseModel.content
        ));
        if((lessonListResponseModel.content??[]).isNotEmpty) {
          add(TagListOnSelectTagEvent(selectTagInfo:(lessonListResponseModel.content??[]).first));       
        }
   

  }

  Future<void> _onDeleteTag(
      TagListOnDeleteTagEvent event,
      Emitter<TagListState> emit,) async {

    DeleteTagApi deleteTagApi = DeleteTagApi(tagInfo: event.selectTagInfo);
    dynamic data = await deleteTagApi.call();
    if(data.runtimeType!=ResponseCommon)
      {
        add(TagListInitEvent());
      }
  }
}