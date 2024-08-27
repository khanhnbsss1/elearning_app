import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/add_word_controller.dart';
import 'package:webkit/services/apis/sentence/models/sentence_info.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/upload_file/upload_file_api.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/services/apis/vocabulary/words/add_words_api.dart';
import 'package:webkit/services/apis/vocabulary/words/update_words_api.dart';
import 'package:webkit/views/vocabulary/vocabulary_detail/create_edit_words.dart';
part 'create_edit_word_event.dart';
part 'create_edit_word_state.dart';

class CreateEditWordBloc extends Bloc<CreateEditWordEvent, CreateEditWordState> {
  CreateEditWordBloc(super.initialState) {
    on<CreateEditWordInitEvent>(_onInit);
    on<CreateEditWordUploadAudioEvent>(_onUploadAudio);
    on<CreateEditWordUploadImageEvent>(_onUploadImage);
    on<CreateEditWordCreateWordEvent>(_onCreateWord);
    on<CreateEditWordUpdateWordEvent>(_onUpdateWord);

    on<CreateEditWordOnSaveSentenceEvent>(_onSaveSentenceInfo);
    on<CreateEditWordOnUpdateVocabularyInfoEvent>((event, emit) {
      
      emit(state.copyWith(
          blocStatus: CreateEditWordStatus.onUpdateWordInfo,
          vocabularyInfo: event.vocabularyInfo
      ));
    });
    on<CreateEditWordOnAddNewSentenceEvent>((event, emit) {
      if((state.vocabularyInfo?.sentenceInfos??[]).isNotEmpty && state.vocabularyInfo!.sentenceInfos!.last.isValidate())
        {
          state.exampleIndex = state.exampleIndex!-1;
          state.vocabularyInfo?.sentenceInfos?.add(SentenceInfo(id: state.exampleIndex??-1));
        }
      else
        {
          ToastUtils.showToastError("Vui lòng hoàn thành và lưu tất cả ví dụ trước đó");
        }
      emit(state.copyWith(
        blocStatus: CreateEditWordStatus.onCreateNewSentence,
        vocabularyInfo: state.vocabularyInfo,
        exampleIndex: state.exampleIndex
      ));
    });
    on<CreateEditWordOnRemoveSentenceEvent>((event, emit) {
      if((state.vocabularyInfo?.sentenceInfos??[]).where((element) => element.id == event.sentenceInfo.id,).isNotEmpty)
      {
        (state.vocabularyInfo?.sentenceInfos??[]).removeWhere((element) =>  element.id == event.sentenceInfo.id,);
      }
      else if(event.sentenceInfo.id==null && (state.vocabularyInfo?.sentenceInfos??[]).isNotEmpty)/// xoa item o cuoi
        {
          (state.vocabularyInfo?.sentenceInfos??[]).removeLast();
        }
      else
      {
        ToastUtils.showToastError("Vui lòng hoàn thành và lưu ví dụ trước đó");
      }
      emit(state.copyWith(
          blocStatus: CreateEditWordStatus.onCreateNewSentence,
          vocabularyInfo: state.vocabularyInfo
      ));
    });
  }
  Future<void> _onInit(
      CreateEditWordInitEvent event,
      Emitter<CreateEditWordState> emit,
      ) async {
    
    if((state.vocabularyInfo?.sentenceInfos??[]).isEmpty  )
      {
        if(state.wordsPageActionType != WordsPageActionType.view)
          {
            state.vocabularyInfo?.sentenceInfos = [];
            state.vocabularyInfo?.sentenceInfos?.add(SentenceInfo(id: 0));
          }
      }
    emit(state.copyWith(
      blocStatus: CreateEditWordStatus.initial,
      vocabularyInfo: state.vocabularyInfo
    ));
  }


  Future<void> _onUploadAudio(
      CreateEditWordUploadAudioEvent event,
      Emitter<CreateEditWordState> emit,
      ) async {
    emit(state.copyWith(
      blocStatus: CreateEditWordStatus.onLoading,
    )); 
    
    UploadFileApi uploadFileApi = UploadFileApi(fileInfo: event.data);
    UploadFileResponseInfo? data = await uploadFileApi.call();

    if(data!=null)
      {
        state.addWordController?.basicValidator.getController('audio')?.text = event.data.fileName??"";
        state.vocabularyInfo?.audioFileInfo = data;
        state.vocabularyInfo?.audioLink = data.link;
        state.vocabularyInfo?.audioId = data.id;
        state.vocabularyInfo?.audio = data.link;

        emit(state.copyWith(
          blocStatus: CreateEditWordStatus.onUploadAudio,
          audio: data,
          addWordController: state.addWordController,
          vocabularyInfo: state.vocabularyInfo
        ));
      }
  }

  Future<void> _onUploadImage(
      CreateEditWordUploadImageEvent event,
      Emitter<CreateEditWordState> emit,
      ) async {
    emit(state.copyWith(
        blocStatus: CreateEditWordStatus.onLoading,
    )); 
    
    UploadFileApi uploadFileApi = UploadFileApi(fileInfo: event.data);
    UploadFileResponseInfo? data = await uploadFileApi.call();
    if(data!=null)
    {
      state.addWordController?.basicValidator.getController('image')?.text = event.data.fileName??"";
      state.vocabularyInfo?.imageFileInfo = data;
      state.vocabularyInfo?.imageId = data.id;
      state.vocabularyInfo?.imageLink = data.link;
      emit(state.copyWith(
          blocStatus: CreateEditWordStatus.onUploadImage, 
          image: data,
          addWordController: state.addWordController,
          vocabularyInfo: state.vocabularyInfo
      ));
    }  
  }
  Future<void> _onCreateWord(
      CreateEditWordCreateWordEvent event,
      Emitter<CreateEditWordState> emit,
      ) async {
    emit(state.copyWith(
      blocStatus: CreateEditWordStatus.onLoading,
    ));
    
    UserProfile? userProfile = UserManager().getUserProfile();
    MonitorLoading().showLoading("");
    state.vocabularyInfo?.simplified = event.state.addWordController?.basicValidator.getController('simplified')?.text;
    state.vocabularyInfo?.traditional = event.state.addWordController?.basicValidator.getController('traditional')?.text;
    state.vocabularyInfo?.pinyinTones = event.state.addWordController?.basicValidator.getController('pinyin_tones')?.text;
    state.vocabularyInfo?.audio = event.state.addWordController?.basicValidator.getController('audio')?.text;
    state.vocabularyInfo?.categoryWord = event.state.addWordController?.basicValidator.getController('category')?.text;

    state.vocabularyInfo?.translationVn = event.state.addWordController?.basicValidator.getController('translation_vn')?.text;
    state.vocabularyInfo?.createdBy = userProfile?.userName??"";

    AddWordsApi addWordsApi = AddWordsApi(word:  state.vocabularyInfo!);
    dynamic data = await addWordsApi.call();
    MonitorLoading().dismiss();

    if(data.runtimeType == String && (data as String).isEmpty)
      {
        emit(event.state.copyWith(
          blocStatus: CreateEditWordStatus.onSubmit,
          vocabularyInfo:  state.vocabularyInfo,
        ));
      }

  }  
  Future<void> _onUpdateWord(
      CreateEditWordUpdateWordEvent event,
      Emitter<CreateEditWordState> emit,
      ) async {
    emit(state.copyWith(
      blocStatus: CreateEditWordStatus.onLoading,
    ));

    UserProfile? userProfile = UserManager().getUserProfile();
    MonitorLoading().showLoading("");
    state.vocabularyInfo?.simplified =  event.state.addWordController?.basicValidator.getController('simplified')?.text;
    state.vocabularyInfo?.traditional =  event.state.addWordController?.basicValidator.getController('traditional')?.text;
    state.vocabularyInfo?.translationVn =  event.state.addWordController?.basicValidator.getController('translation_vn')?.text;
    state.vocabularyInfo?.categoryWord = event.state.addWordController?.basicValidator.getController('category')?.text;
    state.vocabularyInfo?.pinyinTones =  event.state.addWordController?.basicValidator.getController('pinyin_tones')?.text;
    state.vocabularyInfo?.audio =  event.state.addWordController?.basicValidator.getController('audio')?.text;
    UpdateWordsApi addWordsApi = UpdateWordsApi(word: state.vocabularyInfo!);
    dynamic data = await addWordsApi.call();
    MonitorLoading().dismiss();


    emit(event.state.copyWith(
      blocStatus: CreateEditWordStatus.onUpdateWord,
      vocabularyInfo: state.vocabularyInfo,
    ));
  }

  Future<void> _onSaveSentenceInfo(
      CreateEditWordOnSaveSentenceEvent event,
      Emitter<CreateEditWordState> emit,
      ) async {
    emit(state.copyWith(
      blocStatus: CreateEditWordStatus.onLoading,
    ));

    MonitorLoading().showLoading("");
    if(event.sentenceInfo.id!=null)/// vi du da ton tai
      {
        if((state.vocabularyInfo?.sentenceInfos??[]).where((element) => element.id == event.sentenceInfo.id,).isNotEmpty){
         int index =  (state.vocabularyInfo?.sentenceInfos??[]).indexWhere((element) => element.id == event.sentenceInfo.id,);
         state.vocabularyInfo?.sentenceInfos![index] = event.sentenceInfo;
        }
        else
          {
            state.vocabularyInfo?.sentenceInfos?.add(event.sentenceInfo.copyWith(id: (state.vocabularyInfo!.sentenceInfos??[]).length));
          }
      }
    MonitorLoading().dismiss();
    emit(state.copyWith(
      blocStatus: CreateEditWordStatus.onSubmit,
      vocabularyInfo: state.vocabularyInfo,
    ));
  }
}
