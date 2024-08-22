part of 'category_list_bloc.dart';

enum CategoryListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
  onSelectTag
}

@immutable
class CategoryListState extends Equatable {
  CategoryListResponseModel? tagListResponseModel;
  CategoryListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  CategoryInfo? selectInfo;
  CategoryListState({
      this.blocStatus, 
    this.tagListResponseModel,
    this.searchCommonRequest,
    this.selectInfo
  }){
    tagListResponseModel??= CategoryListResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(pageNumber: 0, pageSize: 10, keyword: "");
  }


  CategoryListState copyWith({
    CategoryListResponseModel? tagListResponseModel,
    CategoryListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    CategoryInfo? selectInfo
  })
  {
    return CategoryListState(
      blocStatus: blocStatus??this.blocStatus,
      tagListResponseModel: tagListResponseModel??this.tagListResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectInfo: selectInfo??this.selectInfo,

    );
  }
  @override
  List<Object?> get props => [blocStatus, tagListResponseModel, searchCommonRequest, selectInfo];

}