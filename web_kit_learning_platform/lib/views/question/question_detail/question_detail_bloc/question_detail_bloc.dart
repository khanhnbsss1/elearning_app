import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/instance_mananger/filter_manager.dart';
import 'package:webkit/services/apis/question/add_quiz_api.dart';

import 'package:webkit/services/apis/question/models/question_info.dart';
import 'package:webkit/services/apis/question/update_quiz_api.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/upload_file/upload_file_api.dart';

part 'question_detail_event.dart';
part 'question_detail_state.dart';

class QuestionDetailBloc extends Bloc<QuestionDetailEvent, QuestionDetailState> {
  QuestionDetailBloc(super.initialState) {
    on<QuestionDetailInitEvent>(_onInit);
    on<QuestionDetailUpdateQuizEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(
          blocStatus: QuestionDetailStatus.initial,
        listOfWord: event.listOfTest,
        listOfWordRemove: event.listOfTestRemove,
        listOfWordAdd: event.listOfTestAdd
      ));
    });
    on<QuestionDetailUpdateQuestionInfoEvent>((event, emit) {
      // TODO: implement event handler
      if(event.info.questionType == QuestionType.fill)
        {
          state.answerType = AnswerType.text;
        }
      emit(state.copyWith(
          blocStatus: QuestionDetailStatus.onUpdateQuestionInfo,
        questionInfo: event.info,
        answerType: state.answerType
      ));
    });
    on<QuestionDetailChangeAnswerTypeEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(
          blocStatus: QuestionDetailStatus.onUpdateAnswerType,
          answerType: event.answerType
      ));
    });
    on<QuestionDetailUpdateQuestionEvent>(_onUpdateQuestion);
    on<QuestionDetailCreateQuestionEvent>(_onCreatedQuestion);
    on<QuestionDetailUpLoadFileInfoEvent>(_onUploadFile);
    on<QuestionDetailAddAnswerInfoEvent>((event, emit) {
      // TODO: implement event handler
      if((state.questionInfo?.answerGetDetail??[]).length>=6)
        {
          ToastUtils.showToastError("Chỉ được tạo tối đa 6 đáp án");
          return;
        }
      state.questionInfo?.answerGetDetail?.add(AnswerInfo(answerId: state.answerTempIndex!-1, answerType: state.answerType));
      emit(state.copyWith(
          blocStatus: QuestionDetailStatus.onAddAnswer,
          questionInfo: state.questionInfo, 
          answerTempIndex: state.answerTempIndex!-1
      ));
    });

    on<QuestionDetailChangeAnswerInfoEvent>((event, emit) {
      // TODO: implement event handler
      int index = (state.questionInfo?.answerGetDetail??[]).indexWhere((element) => element.answerId == event.answerUploadInfo.answerId,);
      (state.questionInfo?.answerGetDetail??[])[index] = event.answerUploadInfo;
      emit(state.copyWith(
          blocStatus: QuestionDetailStatus.onChangeAnswer,
          questionInfo: state.questionInfo,
      ));
    });

    on<QuestionDetailRemoveAnswerInfoEvent>((event, emit) {
      // TODO: implement event handler
      (state.questionInfo?.answerGetDetail??[]).removeWhere((element) => element.answerId == event.answerUploadInfo.answerId,);
      emit(state.copyWith(
          blocStatus: QuestionDetailStatus.onRemoveAnswer,
          questionInfo: state.questionInfo,
      ));
    });
    
  }
  Future<void> _onInit(
      QuestionDetailInitEvent event,
      Emitter<QuestionDetailState> emit,
      ) async {
    state.blocStatus = QuestionDetailStatus.initial;
    UserProfile? userProfile = UserManager().getUserProfile();
    state.questionInfo??=QuestionInfo(createdBy: userProfile?.userName??'');
    if((state.questionInfo?.answerGetDetail??[]).isNotEmpty)
      {
        state.answerType = (state.questionInfo?.answerGetDetail??[]).first.getAnswerType();
      }
    else
      {
        state.answerType= AnswerType.text;
      }
    if(state.questionInfo?.id!=null)
      {
        state.editingControllerQuestionName?.text = state.questionInfo?.questionName??"";
        state.editingControllerAttackFile?.text = state.questionInfo?.questionLink??"";
        state.editingControllerQuestionScore?.text= (state.questionInfo?.weightage??0).toString();
      }
    FilterInfo? addCourseFilterModel = await FilterManager().getCourseFilter();
    state.listOfGradeNames = addCourseFilterModel.listOfGradeNames;
    emit(state.copyWith(
      blocStatus: QuestionDetailStatus.initial,
      listOfGradeNames: state.listOfGradeNames,
      answerType: state.answerType
    ));
  }
  Future<void> _onUpdateQuestion(
      QuestionDetailUpdateQuestionEvent event,
      Emitter<QuestionDetailState> emit,
      ) async {
    state.blocStatus = QuestionDetailStatus.initial;
    if(state.questionInfo?.id!=null)
    {
      MonitorLoading().showLoading("");
      for(AnswerInfo answerInfo in state.questionInfo?.answerGetDetail??[])
      {
        answerInfo.answerType = state.answerType;
      }
      UpdateQuizApi getLessonDetailApi = UpdateQuizApi(info: state.questionInfo!);
      dynamic data = await getLessonDetailApi.call();
      if(data.runtimeType==String && (data as String).isEmpty)
      {
        MonitorLoading().dismiss();
        emit(state.copyWith(
            blocStatus: QuestionDetailStatus.onUpdateQuestion,
            questionInfo: state.questionInfo
        ));
      }
    }

  }
  Future<void> _onCreatedQuestion(
      QuestionDetailCreateQuestionEvent event,
      Emitter<QuestionDetailState> emit,
      ) async {
    state.blocStatus = QuestionDetailStatus.initial;
      MonitorLoading().showLoading("");
      state.questionInfo = event.info;
      for(AnswerInfo answerInfo in state.questionInfo?.answerGetDetail??[])
        {
          answerInfo.answerType = state.answerType;
        }
    state.questionInfo?.weightage = int.tryParse(state.editingControllerQuestionScore?.text??'0');
    AddQuizApi getLessonDetailApi = AddQuizApi(info: state.questionInfo!);
      dynamic data = (await getLessonDetailApi.call());
      if(data.runtimeType == String )
        {
         // state.testInfo?.id =data;
          emit(state.copyWith(
              blocStatus: QuestionDetailStatus.onCreateQuestion,
              questionInfo: state.questionInfo
          ));
        }
      
    MonitorLoading().dismiss();
    FilterManager().getQuestionListAll("",isReload: true);

  }

  Future<void> _onUploadFile(
      QuestionDetailUpLoadFileInfoEvent event,
      Emitter<QuestionDetailState> emit,
      ) async {
    state.blocStatus = QuestionDetailStatus.initial;
    MonitorLoading().showLoading("");
    UploadFileApi uploadFileApi = UploadFileApi(fileInfo: event.uploadFileInfo);
    UploadFileResponseInfo? uploadFileResponseInfo = await uploadFileApi.call();
    if(uploadFileResponseInfo!=null)
      {

        state.editingControllerAttackFile?.text = event.uploadFileInfo.fileName??"";
        state.questionInfo?.fileId = uploadFileResponseInfo.id;
        state.questionInfo?.uploadInfo = uploadFileResponseInfo;
        state.questionInfo?.questionLink = uploadFileResponseInfo.link;
        emit(state.copyWith(
            blocStatus: QuestionDetailStatus.onUpdateFile,
            questionInfo: state.questionInfo,
            editingControllerAttackFile: state.editingControllerAttackFile
        ));
      }
    MonitorLoading().dismiss();

  }
}

