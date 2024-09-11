part of 'vocabulary_list_bloc.dart';

enum VocabularyStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
  onSelectWord
}
enum VocabularyType{
  vocabularyNonImage,
  vocabularyImage
}


@immutable
class VocabularyListState extends Equatable {
  VocabularyResponseModel? vocabularyResponseModel;
  VocabularyStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  VocabularyType? vocabularyType;
  VocabularyInfo? selectVocabularyInfo;
  VocabularyListState({
      this.blocStatus, 
    this.vocabularyResponseModel,
    this.searchCommonRequest,
    this.vocabularyType,
    this.selectVocabularyInfo
  }){
    vocabularyResponseModel??= VocabularyResponseModel(content: []);
    vocabularyType??= VocabularyType.vocabularyNonImage;
    searchCommonRequest??= SearchCommonRequest( 
        pageNumber: 0, 
        pageSize: 10, 
        keyword: "", 
        type: vocabularyType== VocabularyType.vocabularyNonImage? "NoImage":"Image");
  }


  VocabularyListState copyWith({
    VocabularyResponseModel? vocabularyResponseModel,
    VocabularyStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    VocabularyType? vocabularyType,
    VocabularyInfo? selectVocabularyInfo,
    
  })
  {
    return VocabularyListState(
      blocStatus: blocStatus??this.blocStatus,
      vocabularyResponseModel: vocabularyResponseModel??this.vocabularyResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      vocabularyType: vocabularyType??this.vocabularyType,
      selectVocabularyInfo: selectVocabularyInfo??this.selectVocabularyInfo,

    );
  }
  @override
  List<Object?> get props => [blocStatus, vocabularyResponseModel, searchCommonRequest,vocabularyType, selectVocabularyInfo];

}