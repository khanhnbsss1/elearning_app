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
  List<TagsInfo>? contentView;
  TagListState({
      this.blocStatus, 
    this.tagListResponseModel,
    this.searchCommonRequest,
    this.selectTagInfo,
    this.contentView
  }){
    tagListResponseModel??= TagListResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(pageNumber: 0, pageSize: 10, keyword: "");
  }


  TagListState copyWith({
    TagListResponseModel? tagListResponseModel,
    TagListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    TagsInfo? selectTagInfo,
    List<TagsInfo>? contentView
  })
  {
    return TagListState(
      blocStatus: blocStatus??this.blocStatus,
      tagListResponseModel: tagListResponseModel??this.tagListResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectTagInfo: selectTagInfo??this.selectTagInfo,
      contentView: contentView??this.contentView,

    );
  }
  @override
  List<Object?> get props => [blocStatus, tagListResponseModel, searchCommonRequest, selectTagInfo,contentView];

}