import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc(super.initialState) {
    on<BaseInitEvent>(_onInit);
  }
  Future<void> _onInit(
      BaseInitEvent event,
      Emitter<BaseState> emit,
      ) async {
    state.blocStatus = BaseStatus.initial;
  }

}
