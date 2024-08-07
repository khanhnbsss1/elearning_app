part of 'tag_list_bloc.dart';

enum TagListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
  onSelectTag
}

@immutable
class TagListState extends Equatable {
  TagListResponseModel? tagListResponseModel;
  TagListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  TagsInfo? selectTagInfo;
  TagListState({
      this.blocStatus, 
    this.tagListResponseModel,
    this.searchCommonRequest,
    this.selectTagInfo
  }){
    tagListResponseModel??= TagListResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(pageNumber: 0, pageSize: 10, keyword: "B");
  }


  TagListState copyWith({
    TagListResponseModel? tagListResponseModel,
    TagListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    TagsInfo? selectTagInfo
  })
  {
    return TagListState(
      blocStatus: blocStatus??this.blocStatus,
      tagListResponseModel: tagListResponseModel??this.tagListResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectTagInfo: selectTagInfo??this.selectTagInfo,

    );
  }
  @override
  List<Object?> get props => [blocStatus, tagListResponseModel, searchCommonRequest, selectTagInfo];

}