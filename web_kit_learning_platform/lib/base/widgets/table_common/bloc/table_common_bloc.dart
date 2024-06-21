import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
part 'table_common_event.dart';
part 'table_common_state.dart';

class TableCommonBloc extends Bloc<TableCommonEvent, TableCommonState> {
  TableCommonBloc(TableCommonState initialState) : super(initialState) {
    on<TableCommonInitEvent>(_onInit);
    on<TableCommonUpdateColumnSizeEvent>(_onUpdateColumnSize);
    on<TableCommonRefreshTableEvent>((event, emit) async {
      emit(state.copyWith(
      tableCommonStatus: TableCommonStatus.onRefreshTable
    ));
    });
  }
  Future<void> _onInit(
      TableCommonInitEvent event,
      Emitter<TableCommonState> emit,
      ) async {
    emit(state.copyWith(
        tableCommonStatus: TableCommonStatus.initial,
        tableColumnInfo: TableColumnInfo(index: 0, offsetColumnSize: 0)
    ));
  }

  Future<void> _onUpdateColumnSize(
      TableCommonUpdateColumnSizeEvent event,
      Emitter<TableCommonState> emit,
      ) async {
    emit(state.copyWith(
      tableCommonStatus: TableCommonStatus.updateColumnSize,
      tableColumnInfo: event.tableColumnInfo
    ));
  }
}
