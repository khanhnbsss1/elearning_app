part of 'test_list_bloc.dart';

abstract class TestListEvent extends Equatable {
  const TestListEvent();
  @override
  List<Object?> get props => [];
}

class TestListInitEvent extends TestListEvent {
  TestListInitEvent();  
  @override
  List<Object?> get props => [];
}

class TestListOnSearchByFilterEvent extends TestListEvent {
  SearchCommonRequest searchCommonRequest;
  TestListOnSearchByFilterEvent({required this.searchCommonRequest} );
  @override
  List<Object?> get props => [searchCommonRequest];
}
class TestListOnSelectTestEvent extends TestListEvent {
  TestInfo selectInfo;
  TestListOnSelectTestEvent({required this.selectInfo} );
  @override
  List<Object?> get props => [selectInfo];
}
class TestListOnDeleteTagEvent extends TestListEvent {
  TestInfo selectInfo;
  TestListOnDeleteTagEvent({required this.selectInfo} );
  @override
  List<Object?> get props => [selectInfo];
}