part of 'request_register_list_bloc.dart';

enum RequestRegisterListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
}

enum ActionStatus{
  New,
  Accept,
  Decline
}
Map<ActionStatus, String>mapActionStatusToStr={
  ActionStatus.New:"New",
  ActionStatus.Accept:"Accept",
  ActionStatus.Decline:"Decline",

};

@immutable
class RequestRegisterListState extends Equatable {
  RequestRegisteredListResponseModel? listResponseModel;
  RequestRegisterListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  RegisteredInfo? selectInfo;
  ActionStatus? status;
  RequestRegisterListState({
      this.blocStatus, 
    this.listResponseModel,
    this.searchCommonRequest,
    this.selectInfo,
    this.status
  }){
    listResponseModel??= RequestRegisteredListResponseModel(content: []);
    DateTime endTime = DateTime.now();
    DateTime startTime = endTime.copyWith(
      month: endTime.month-1
    );
    String startTimeStr = DateTimeHelper.formatDate(DateTimeHelper.yyyyMMDD, startTime);
    String endTimeStr = DateTimeHelper.formatDate(DateTimeHelper.yyyyMMDD, endTime);

    searchCommonRequest??= SearchCommonRequest(
        pageNumber: 0, 
        pageSize: 20, 
        keyword: "", 
        startDate: startTimeStr, 
        endDate: endTimeStr, 
       // status: mapActionStatusToStr[ActionStatus.New]
    );
  }


  RequestRegisterListState copyWith({
    RequestRegisteredListResponseModel? listResponseModel,
    RequestRegisterListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    RegisteredInfo? selectInfo,
    ActionStatus? status
  })
  {
    return RequestRegisterListState(
      blocStatus: blocStatus??this.blocStatus,
      listResponseModel: listResponseModel??this.listResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectInfo: selectInfo??this.selectInfo,
      status: status??this.status,

    );
  }
  @override
  List<Object?> get props => [blocStatus, listResponseModel, searchCommonRequest, selectInfo, status];

}