import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:webkit/helpers/localizations/language_helper.dart';
import 'package:webkit/helpers/theme/app_notifier.dart';

import '../language.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(MainState mainState) : super(MainState(mainStatus: mainState.mainStatus)){
    on<MainChangeLanguageEvent>(onChangeLanguage);
    on<MainInitEvent>(onInitMain);
    on<MainChangeDarkModeEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(
          mainStatus: MainStatus.onEnableDarkMode,
      ));
    });
  }

  Future<void> onInitMain(MainInitEvent event, Emitter<MainState> emit) async {

      Locale locale = await LanguageHelper().getCurrentLocale();

      MainState locazationState = state.copyWith(locale: locale,mainStatus: MainStatus.initial);
      emit(locazationState);
  }
  Future<void> onChangeLanguage(MainChangeLanguageEvent event, Emitter<MainState> emit) async {

    if(event.locale== null)
      {
        Locale locale = await LanguageHelper().getCurrentLocale();
        emit(state.copyWith(
            locale: locale,
            mainStatus: MainStatus.onchangeLanguage
        ));
      }
    await LanguageHelper().setLocale(event.locale!);
    emit(state.copyWith(locale: event.locale,mainStatus: MainStatus.onchangeLanguage ));
  }
}
