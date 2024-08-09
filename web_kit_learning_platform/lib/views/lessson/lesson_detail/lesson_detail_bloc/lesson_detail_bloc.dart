import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/course/course_detail/ulink_lesson_api.dart';
import 'package:webkit/services/apis/lessson/lesson_detail/add_lesson_api.dart';
import 'package:webkit/services/apis/lessson/lesson_detail/get_lesson_detail.dart';
import 'package:webkit/services/apis/lessson/lesson_detail/update_lesson_api.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/upload_file/upload_file_api.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/services/apis/vocabulary/words/link_lesson_api.dart';
import 'package:webkit/services/apis/vocabulary/words/unlink_lesson_api.dart';
part 'lesson_detail_event.dart';
part 'lesson_detail_state.dart';

class LessonDetailBloc extends Bloc<LessonDetailEvent, LessonDetailState> {
  LessonDetailBloc(super.initialState) {
    on<LessonDetailInitEvent>(_onInit);
    on<LessonDetailUpdateWordsEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(
          blocStatus: LessonDetailStatus.initial,
        listOfWord: event.listOfWord,
        listOfWordRemove: event.listOfWordRemove,
        listOfWordAdd: event.listOfWordAdd
      ));
    });
    on<LessonDetailUpdateLessonEvent>(_onUpdateLesson);
    on<LessonDetailCreateLessonEvent>(_onCreatedLesson);
    on<LessonDetailUploadDocumentEvent>(_onUploadDocument);

  }
  Future<void> _onInit(
      LessonDetailInitEvent event,
      Emitter<LessonDetailState> emit,
      ) async {
    state.blocStatus = LessonDetailStatus.initial;
    UserProfile? userProfile = await UserManager().getUserProfile();
    state.lessonInfo??=LessonInfo(createdBy: userProfile?.userName??'');
    if(state.lessonInfo?.id!=null)
      {
        emit(state.copyWith(
            blocStatus: LessonDetailStatus.onLoading,
        ));
        
        GetLessonDetailApi getLessonDetailApi = GetLessonDetailApi(lessonId: state.lessonInfo?.id??0);
        state.lessonInfo = (await getLessonDetailApi.call())?? state.lessonInfo;
        state.listOfWord = [...state.lessonInfo?.vocabularies??[]];
      }
    emit(state.copyWith(
      blocStatus: LessonDetailStatus.initial,
      lessonInfo: state.lessonInfo,
      listOfWord: state.listOfWord,
    ));
  }
  Future<void> _onUpdateLesson(
      LessonDetailUpdateLessonEvent event,
      Emitter<LessonDetailState> emit,
      ) async {
    state.blocStatus = LessonDetailStatus.initial;
    if(state.lessonInfo?.id!=null)
    {
      MonitorLoading().showLoading("");
      UpdateLessonApi getLessonDetailApi = UpdateLessonApi(lessonInfo: event.lessonInfo);
      dynamic data = await getLessonDetailApi.call();
      if(data.runtimeType==String && (data as String).isEmpty)
      {
        await _onLinkAndUnlinkWordToLesson();

        MonitorLoading().dismiss();

        emit(state.copyWith(
            blocStatus: LessonDetailStatus.onUpdateLesson,
            lessonInfo: state.lessonInfo
        ));
      }
    }

  }
  Future<void> _onCreatedLesson(
      LessonDetailCreateLessonEvent event,
      Emitter<LessonDetailState> emit,
      ) async {
    state.blocStatus = LessonDetailStatus.initial;
      MonitorLoading().showLoading("");
      AddLessonApi getLessonDetailApi = AddLessonApi(lessonInfo: event.lessonInfo);
      dynamic data = (await getLessonDetailApi.call());
      if(data.runtimeType == int )
        {
          state.lessonInfo?.id =data;
          await _onLinkAndUnlinkWordToLesson();
          emit(state.copyWith(
              blocStatus: LessonDetailStatus.onCreateLesson,
              lessonInfo: state.lessonInfo
          ));
        }
    MonitorLoading().dismiss();

  }

  Future<void> _onUploadDocument(
      LessonDetailUploadDocumentEvent event,
      Emitter<LessonDetailState> emit,
      ) async {
    state.blocStatus = LessonDetailStatus.initial;
      MonitorLoading().showLoading("");
      UploadFileApi uploadFileApi = UploadFileApi(fileInfo: event.docInfo);
      UploadFileResponseInfo? data = await uploadFileApi.call();
      if(data!=null)
        {
          state.lessonInfo?.docName = event.docInfo.fileName;
          state.lessonInfo?.docId = data.id;
          state.lessonInfo?.documentUploadInfo = data;
          emit(state.copyWith(
            blocStatus: LessonDetailStatus.onUploadDoc,
            lessonInfo: state.lessonInfo
          ));
        }
    MonitorLoading().dismiss();

  }

  Future<void> _onLinkAndUnlinkWordToLesson()async {
    if((state.listOfWordAdd??[]).isNotEmpty)
      {
        LinkWordApi linkWordApi = LinkWordApi(lessonId: state.lessonInfo?.id??0, vocabularyInfos: state.listOfWordAdd??[]);
        dynamic data = await linkWordApi.call();
      }

    if((state.listOfWordRemove??[]).isNotEmpty)
    {
      UnLinkWordApi unlinkWordApi = UnLinkWordApi(lessonId: state.lessonInfo?.id??0, vocabularyInfos: state.listOfWordRemove??[]);
      dynamic data = await unlinkWordApi.call();
    }
  }
}

