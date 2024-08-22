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
  List<CategoryInfo>? contentView;
  CategoryListState({
      this.blocStatus, 
    this.tagListResponseModel,
    this.searchCommonRequest,
    this.selectInfo,
    this.contentView
  }){
    tagListResponseModel??= CategoryListResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(pageNumber: 0, pageSize: 10, keyword: "");
  }


  CategoryListState copyWith({
    CategoryListResponseModel? tagListResponseModel,
    CategoryListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    CategoryInfo? selectInfo,
    List<CategoryInfo>? contentView
  })
  {
    return CategoryListState(
      blocStatus: blocStatus??this.blocStatus,
      tagListResponseModel: tagListResponseModel??this.tagListResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectInfo: selectInfo??this.selectInfo,
      contentView: contentView??this.contentView,

    );
  }
  @override
  List<Object?> get props => [blocStatus, tagListResponseModel, searchCommonRequest, selectInfo, contentView];

}