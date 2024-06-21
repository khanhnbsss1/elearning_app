part of 'table_common_bloc.dart';

enum TableCommonStatus {
  unknown,
  initial,
  updateColumnSize,
  onRefreshTable
}
class TableColumnInfo{
  int index = 0;
  double offsetColumnSize = 0;
  int? totalColumnWithStep = 0;
  Map<String, int>? columnInfo = {};
  TableColumnInfo({required this.index, required this.offsetColumnSize, this.totalColumnWithStep, this.columnInfo});

  TableColumnInfo copyWith({
    int? index,
    double? offsetColumnSize,
    int? totalColumnWithStep ,
    Map<String, int>? columnInfo
  })
  {
    return TableColumnInfo(
        index: index??this.index,
        offsetColumnSize: offsetColumnSize??this.offsetColumnSize,
        totalColumnWithStep: totalColumnWithStep??this.totalColumnWithStep,
        columnInfo: columnInfo??this.columnInfo,
    );
  }
}
@immutable
class TableCommonState extends Equatable {
  TableCommonStatus tableCommonStatus;
  double? widthOftable;
  TableColumnInfo ? tableColumnInfo = TableColumnInfo(index: 0, offsetColumnSize: 0);

  TableCommonState({
      required this.tableCommonStatus,
    this.widthOftable,
    this.tableColumnInfo
  });


  TableCommonState copyWith({
    TableCommonStatus? tableCommonStatus,
    double? widthOftable,
    TableColumnInfo ? tableColumnInfo
  })
  {
    return TableCommonState(
      tableCommonStatus: tableCommonStatus??this.tableCommonStatus,
      widthOftable: widthOftable??this.widthOftable,
        tableColumnInfo: tableColumnInfo??this.tableColumnInfo??TableColumnInfo(index: 0, offsetColumnSize: 0)
    );
  }
  @override
  List<Object?> get props => [tableCommonStatus, widthOftable, tableColumnInfo];

}