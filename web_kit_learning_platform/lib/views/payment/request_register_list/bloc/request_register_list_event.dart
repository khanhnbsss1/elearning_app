part of 'request_register_list_bloc.dart';

abstract class RequestRegisterListEvent extends Equatable {
  const RequestRegisterListEvent();
  @override
  List<Object?> get props => [];
}

class RequestRegisterListInitEvent extends RequestRegisterListEvent {
  RequestRegisterListInitEvent();  
  @override
  List<Object?> get props => [];
}

class RequestRegisterListOnSearchByFilterEvent extends RequestRegisterListEvent {
  SearchCommonRequest searchCommonRequest;
  RequestRegisterListState? state;
  RequestRegisterListOnSearchByFilterEvent({required this.searchCommonRequest, this.state} );
  @override
  List<Object?> get props => [searchCommonRequest, state];
}
class RequestRegisterListOnSelectTestEvent extends RequestRegisterListEvent {
  TestInfo selectInfo;
  RequestRegisterListOnSelectTestEvent({required this.selectInfo} );
  @override
  List<Object?> get props => [selectInfo];
}
class RequestRegisterListOnDeleteTagEvent extends RequestRegisterListEvent {
  TestInfo selectInfo;
  RequestRegisterListOnDeleteTagEvent({required this.selectInfo} );
  @override
  List<Object?> get props => [selectInfo];
}