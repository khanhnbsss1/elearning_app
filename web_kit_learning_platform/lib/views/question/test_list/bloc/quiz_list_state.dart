part of 'quiz_list_bloc.dart';

enum QuizListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
  onSelectTag
}

@immutable
class QuizListState extends Equatable {
  QuestionListResponseModel? listResponseModel;
  QuizListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  QuestionInfo? selectInfo;
  QuizListState({
    this.blocStatus,
    this.listResponseModel,
    this.searchCommonRequest,
    this.selectInfo
  }){
    listResponseModel??= QuestionListResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(pageNumber: 0, pageSize: 10, keyword: "B");
  }


  QuizListState copyWith({
    QuestionListResponseModel? listResponseModel,
    QuizListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    QuestionInfo? selectInfo
  })
  {
    return QuizListState(
      blocStatus: blocStatus??this.blocStatus,
      listResponseModel: listResponseModel??this.listResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectInfo: selectInfo??this.selectInfo,

    );
  }
  @override
  List<Object?> get props => [blocStatus, listResponseModel, searchCommonRequest, selectInfo];

}

