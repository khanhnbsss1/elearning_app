part of 'revenue_history_bloc.dart';

abstract class RevenueHistoryListEvent extends Equatable {
  const RevenueHistoryListEvent();
  @override
  List<Object?> get props => [];
}

class RevenueHistoryListInitEvent extends RevenueHistoryListEvent {
  RevenueHistoryListInitEvent();  
  @override
  List<Object?> get props => [];
}
class RevenueHistoryListOnSearchByFilterEvent extends RevenueHistoryListEvent {
  SearchCommonRequest searchCommonRequest;
  RevenueHistoryListOnSearchByFilterEvent({required this.searchCommonRequest} );
  @override
  List<Object?> get props => [searchCommonRequest];
}
class LessonListOnSelectLessonEvent extends RevenueHistoryListEvent {
  LessonInfo selectLessonInfo;
  LessonListOnSelectLessonEvent({required this.selectLessonInfo} );
  @override
  List<Object?> get props => [selectLessonInfo];
}