import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/instance_mananger/filter_manager.dart';
import 'package:webkit/services/apis/category/models/category_info.dart';
import 'package:webkit/services/apis/lessson/lesson_detail/add_lesson_api.dart';
import 'package:webkit/services/apis/lessson/lesson_detail/get_lesson_detail.dart';
import 'package:webkit/services/apis/lessson/lesson_detail/update_lesson_api.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/test/link_test_to_lesson_api.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';
import 'package:webkit/services/apis/test/unklink_test_from_lesson_api.dart';
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
    on<LessonDetailChangeLessonEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(
          blocStatus: LessonDetailStatus.onChangeLesson,
        lessonInfo: event.lessonInfo
      ));
    });
    on<LessonDetailOnAddVideoInfoEvent>((event, emit) {
      // TODO: implement event handler
      state.videoIndex = state.videoIndex! +1;
      state.lessonInfo?.videoInfos?.link?.add(VideoInfo(order: state.videoIndex, videoTitle: "", videoLink: ""));
      emit(state.copyWith(
          blocStatus: LessonDetailStatus.onChangeLesson,
          lessonInfo: state.lessonInfo
      ));
    });
    on<LessonDetailOnRemoveVideoInfoEvent>((event, emit) {
      // TODO: implement event handler
      (state.lessonInfo?.videoInfos?.link??[]).removeWhere((element) => element.order == event.videoInfo.order,);
      emit(state.copyWith(
          blocStatus: LessonDetailStatus.onChangeLesson,
          lessonInfo: state.lessonInfo
      ));
    });

    on<LessonDetailOnUpdateVideoInfoEvent>((event, emit) {
      // TODO: implement event handler
     int index =  (state.lessonInfo?.videoInfos?.link??[]).indexWhere((element) => element.order == event.videoInfo.order,);
     (state.lessonInfo?.videoInfos?.link??[])[index] = event.videoInfo;
      emit(state.copyWith(
          blocStatus: LessonDetailStatus.onChangeLesson,
          lessonInfo: state.lessonInfo
      ));
    });
    
    on<LessonDetailUpdateLessonEvent>(_onUpdateLesson);
    on<LessonDetailCreateLessonEvent>(_onCreatedLesson);
    on<LessonDetailUploadDocumentEvent>(_onUploadDocument);
    on<LessonDetailUploadContentDocEvent>(_onUploadContent);

    on<LessonDetailUpdateTestInfoEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(
          blocStatus: LessonDetailStatus.initial,
        testInfo: event.testInfo
      ));
    });
  }
  Future<void> _onInit(
      LessonDetailInitEvent event,
      Emitter<LessonDetailState> emit,
      ) async {
    state.blocStatus = LessonDetailStatus.initial;
    UserProfile? userProfile = UserManager().getUserProfile();
    state.lessonInfo??=LessonInfo(createdBy: userProfile?.userName??'');
    if(state.lessonInfo?.id!=null)
      {
        emit(state.copyWith(
            blocStatus: LessonDetailStatus.onLoading,
        ));
        
        GetLessonDetailApi getLessonDetailApi = GetLessonDetailApi(lessonId: state.lessonInfo?.id??0);
        state.lessonInfo = (await getLessonDetailApi.call())?? state.lessonInfo;
        state.listOfWord = [...state.lessonInfo?.vocabularies??[]];
        state.editingControllerLectureName?.text = state.lessonInfo?.lectureName??"";
        state.editingControllerLectureDescription?.text = state.lessonInfo?.note??"";
        state.editingControllerLectureContent?.text = state.lessonInfo?.content??"";
        //state.editingControllerLectureVideoLink?.text = state.lessonInfo?.link??"";
        state.editingControllerLectureDocuments?.text = state.lessonInfo?.docName??"";
        state.testInfo = TestInfo(id: state.lessonInfo?.testId, name: state.lessonInfo?.testName);
        CategoryListResponseModel? categoryListResponseModel = await FilterManager().getCategoryFilter();
        if((categoryListResponseModel?.content??[]).where((element) => element.id == state.lessonInfo?.categoryId).isNotEmpty) {
          state.valueListenable?.value = (categoryListResponseModel?.content??[]).firstWhere((element) => element.id == state.lessonInfo?.categoryId);
        }
      }
    if((state.lessonInfo?.videoInfos?.link??[]).isEmpty)
      {
        (state.lessonInfo?.videoInfos?.link??[]).add(VideoInfo(order: 0,videoLink: "",videoTitle: ""));
      }
    else
      {
        state.videoIndex = (state.lessonInfo?.videoInfos?.link??[]).last.order!;
      }
    emit(state.copyWith(
      blocStatus: LessonDetailStatus.initial,
      testInfo: state.testInfo,
      lessonInfo: state.lessonInfo,
      listOfWord: state.listOfWord,
      videoIndex: state.videoIndex
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
      state.lessonInfo = event.lessonInfo;
      if(!validateVideoInfo())
      {
        ToastUtils.showToastError("Vui lòng hoàn thành tất cả thông tin video");
        MonitorLoading().dismiss();
        return;
      }
      UpdateLessonApi getLessonDetailApi = UpdateLessonApi(lessonInfo: state.lessonInfo!);
      dynamic data = await getLessonDetailApi.call();
      if(data.runtimeType==String && (data as String).isEmpty)
      {
        await _onLinkAndUnlinkWordToLesson();
        await _onLinkTestToLesson();
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
      state.lessonInfo = event.lessonInfo;
      if(!validateVideoInfo())
        {
          ToastUtils.showToastError("Vui lòng hoàn thành tất cả thông tin video");
          MonitorLoading().dismiss();
          return;
        }
      AddLessonApi getLessonDetailApi = AddLessonApi(lessonInfo: state.lessonInfo!);
      dynamic data = (await getLessonDetailApi.call());
      if(data.runtimeType == int )
        {
          state.lessonInfo?.id =data;
          await _onLinkAndUnlinkWordToLesson();
          await _onLinkTestToLesson();
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

  Future<void> _onUploadContent(
      LessonDetailUploadContentDocEvent event,
      Emitter<LessonDetailState> emit,
      ) async {
    state.blocStatus = LessonDetailStatus.initial;
    MonitorLoading().showLoading("");
    UploadFileApi uploadFileApi = UploadFileApi(fileInfo: event.docInfo);
    UploadFileResponseInfo? data = await uploadFileApi.call();
    if(data!=null)
    {
    state.editingControllerLectureContent?.text = data.link??"";
      emit(state.copyWith(
          blocStatus: LessonDetailStatus.onUploadDoc,
          lessonInfo: state.lessonInfo,
        editingControllerLectureContent: state.editingControllerLectureContent
      ));
    }
    MonitorLoading().dismiss();

  }
  
  Future<void> _onLinkAndUnlinkWordToLesson()async {
    if((state.listOfWordAdd??[]).isNotEmpty) /// link là replace luôn nên ko cần unlink nữa
      {
        LinkWordApi linkWordApi = LinkWordApi(lessonId: state.lessonInfo?.id??0, vocabularyInfos: state.listOfWord??[]);
        dynamic data = await linkWordApi.call();
      }
    
  }

  Future<void> _onLinkTestToLesson()async {
    if(state.testInfo!=null && state.testInfo?.id != state.lessonInfo?.testId)
    {
      
      /// Cần phải unlink trước khi link tới 1 test khác
      UnLinkTestToLessonApi unlinkWordApi = UnLinkTestToLessonApi(lessonId: state.lessonInfo?.id??0, testId: state.lessonInfo?.testId??0);
      dynamic unlinkData = await unlinkWordApi.call();
      
      LinkTestToLessonApi linkWordApi = LinkTestToLessonApi(lessonId: state.lessonInfo?.id??0, testId: state.testInfo?.id??0);
      dynamic linkData = await linkWordApi.call();
    }
  }
  
  bool validateVideoInfo(){
    for(int order=0; order< (state.lessonInfo?.videoInfos?.link??[]).length; order++){
     
      if(!(state.lessonInfo?.videoInfos?.link??[])[order].isValidate())
        {
          return false;
        }
      else
        {
          (state.lessonInfo?.videoInfos?.link??[])[order].order = order;
        }
    }
    return true;
  }
}

