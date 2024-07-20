part of 'vocabulary_list_bloc.dart';

enum VocabularyStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd
}
enum VocabularyType{
  vocabularyList,
  myVocabularyList
}

@immutable
class VocabularyListState extends Equatable {
  VocabularyResponseModel? vocabularyResponseModel;
  VocabularyStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  VocabularyType? vocabularyType;
  VocabularyListState({
      this.blocStatus, 
    this.vocabularyResponseModel,
    this.searchCommonRequest,
    this.vocabularyType
  }){
    vocabularyResponseModel??= VocabularyResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(filterType: "ALL", pageNumber: 0, pageSize: 10, keyword: "");
    vocabularyType??= VocabularyType.vocabularyList;
  }


  VocabularyListState copyWith({
    VocabularyResponseModel? vocabularyResponseModel,
    VocabularyStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    VocabularyType? vocabularyType
  })
  {
    return VocabularyListState(
      blocStatus: blocStatus??this.blocStatus,
      vocabularyResponseModel: vocabularyResponseModel??this.vocabularyResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      vocabularyType: vocabularyType??this.vocabularyType,

    );
  }
  @override
  List<Object?> get props => [blocStatus, vocabularyResponseModel, searchCommonRequest,vocabularyType];

}