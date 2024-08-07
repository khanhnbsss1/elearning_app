import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/add_word_controller.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/upload_file/upload_file_api.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
part 'create_edit_word_event.dart';
part 'create_edit_word_state.dart';

class CreateEditWordBloc extends Bloc<CreateEditWordEvent, CreateEditWordState> {
  CreateEditWordBloc(super.initialState) {
    on<CreateEditWordInitEvent>(_onInit);
    on<CreateEditWordUploadAudioEvent>(_onUploadAudio);
    on<CreateEditWordUploadImageEvent>(_onUploadImage);

  }
  Future<void> _onInit(
      CreateEditWordInitEvent event,
      Emitter<CreateEditWordState> emit,
      ) async {
    state.exampleTextControllers?.add(new TextEditingController());
    state.exampleMeaningControllers?.add(new TextEditingController());
    state.exampleSimplifiedControllers?.add(new TextEditingController());
    state.exampleSoundControllers?.add(new TextEditingController());
    emit(state.copyWith(
      blocStatus: CreateEditWordStatus.initial,
      exampleTextControllers:state.exampleTextControllers,
      exampleMeaningControllers:state.exampleMeaningControllers,
      exampleSimplifiedControllers:state.exampleSimplifiedControllers,
      exampleSoundControllers:state.exampleSoundControllers,
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
        emit(state.copyWith(
          blocStatus: CreateEditWordStatus.onUploadAudio,
          audio: data,
          addWordController: state.addWordController
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
      emit(state.copyWith(
          blocStatus: CreateEditWordStatus.onUploadImage,
          image: data
      ));
    }  
  }
}
