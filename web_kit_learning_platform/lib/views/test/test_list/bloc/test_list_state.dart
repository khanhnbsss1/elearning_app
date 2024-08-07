part of 'test_list_bloc.dart';

enum TestListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
  onSelectTag
}

@immutable
class TestListState extends Equatable {
  TestListResponseModel? listResponseModel;
  TestListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  TestInfo? selectInfo;
  TestListState({
      this.blocStatus, 
    this.listResponseModel,
    this.searchCommonRequest,
    this.selectInfo
  }){
    listResponseModel??= TestListResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(pageNumber: 0, pageSize: 10, keyword: "B");
  }


  TestListState copyWith({
    TestListResponseModel? listResponseModel,
    TestListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    TestInfo? selectInfo
  })
  {
    return TestListState(
      blocStatus: blocStatus??this.blocStatus,
      listResponseModel: listResponseModel??this.listResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectInfo: selectInfo??this.selectInfo,

    );
  }
  @override
  List<Object?> get props => [blocStatus, listResponseModel, searchCommonRequest, selectInfo];

}