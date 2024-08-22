import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/category/delete_category_api.dart';
import 'package:webkit/services/apis/category/get_category_list.dart';
import 'package:webkit/services/apis/category/models/category_info.dart';
import 'package:webkit/services/apis/grade/delete_grade_api.dart';
import 'package:webkit/services/apis/grade/get_grade_list.dart';
import 'package:webkit/services/apis/grade/models/grade_info.dart';

part 'category_list_event.dart';

part 'category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  CategoryListBloc(super.initialState) {
    on<CategoryListInitEvent>(_onInit);
    on<CategoryListOnSearchByFilterEvent>(_onSearchByParams);
    on<CategoryListOnDeleteTagEvent>(_onDeleteTag);

    on<CategoryListOnSelectTagEvent>((event, emit) async {
    });
  }

  Future<void> _onInit(CategoryListInitEvent event,
      Emitter<CategoryListState> emit,) async {
    emit(state.copyWith(
        blocStatus: CategoryListStatus.onLoading,
    ));
    await callTagListApi(searchCommonRequest: state.searchCommonRequest!);
  }

  Future<void> _onSearchByParams(CategoryListOnSearchByFilterEvent event,
      Emitter<CategoryListState> emit,) async {
    emit(state.copyWith(
        blocStatus: CategoryListStatus.onLoading,
        searchCommonRequest: event.searchCommonRequest
    ));
    await callTagListApi(searchCommonRequest: event.searchCommonRequest);
  }
  
  Future<void> callTagListApi({required SearchCommonRequest searchCommonRequest}) async {

    GetCategoryListApi courseApi = GetCategoryListApi();
    CategoryListResponseModel responseModel = await courseApi.call();
        emit(state.copyWith(
            tagListResponseModel: responseModel,
            blocStatus: CategoryListStatus.onLoadEnd,
          searchCommonRequest: searchCommonRequest
        ));
        if((responseModel.content??[]).isNotEmpty) {
          add(CategoryListOnSelectTagEvent(selectInfo:(responseModel.content??[]).first));       
        }
   

  }

  Future<void> _onDeleteTag(
      CategoryListOnDeleteTagEvent event,
      Emitter<CategoryListState> emit,) async {

    DeleteCategoryApi deleteApi = DeleteCategoryApi(info: event.selectInfo);
    dynamic data = await deleteApi.call();
    if(data.runtimeType!=ResponseCommon)
      {
        add(CategoryListInitEvent());
      }
  }
}