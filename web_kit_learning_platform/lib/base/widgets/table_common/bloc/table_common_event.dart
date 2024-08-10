part of 'table_common_bloc.dart';

abstract class TableCommonEvent extends Equatable {
  const TableCommonEvent();
  @override
  List<Object?> get props => [];
}

class TableCommonInitEvent extends TableCommonEvent {
  const TableCommonInitEvent();
  @override
  List<Object?> get props => [];
}

class TableCommonUpdateColumnSizeEvent extends TableCommonEvent {
  TableColumnInfo tableColumnInfo;
  TableCommonUpdateColumnSizeEvent({required this.tableColumnInfo});
  @override
  List<Object?> get props => [tableColumnInfo];
}
class TableCommonRefreshTableEvent extends TableCommonEvent {
  TableCommonRefreshTableEvent();
  @override
  List<Object?> get props => [];
}