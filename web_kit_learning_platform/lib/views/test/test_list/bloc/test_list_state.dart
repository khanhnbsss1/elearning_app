part of 'test_list_bloc.dart';

enum TestListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
}
enum TestListType{
  editList,
  workList
}
@immutable
class TestListState extends Equatable {
  TestListResponseModel? listResponseModel;
  TestListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  TestInfo? selectInfo;
  TestListType? testListType;
  TestListState({
      this.blocStatus, 
    this.listResponseModel,
    this.searchCommonRequest,
    this.selectInfo,
    this.testListType
  }){
    listResponseModel??= TestListResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(pageNumber: 0, pageSize: 10, keyword: "");
    testListType??= TestListType.editList;
  }


  TestListState copyWith({
    TestListResponseModel? listResponseModel,
    TestListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    TestInfo? selectInfo,
    TestListType? testListType
  })
  {
    return TestListState(
      blocStatus: blocStatus??this.blocStatus,
      listResponseModel: listResponseModel??this.listResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectInfo: selectInfo??this.selectInfo,
      testListType: testListType??this.testListType,

    );
  }
  @override
  List<Object?> get props => [blocStatus, listResponseModel, searchCommonRequest, selectInfo, testListType];

}