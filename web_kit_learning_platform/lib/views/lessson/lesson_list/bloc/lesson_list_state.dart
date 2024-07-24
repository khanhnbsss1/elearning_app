part of 'lesson_list_bloc.dart';

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
class LessonListState extends Equatable {
  VocabularyResponseModel? vocabularyResponseModel;
  VocabularyStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  VocabularyType? vocabularyType;
  VocabularyInfo? selectVocabularyInfo;
  LessonListState({
      this.blocStatus, 
    this.vocabularyResponseModel,
    this.searchCommonRequest,
    this.vocabularyType,
    this.selectVocabularyInfo
  }){
    vocabularyResponseModel??= VocabularyResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(filterType: "ALL", pageNumber: 0, pageSize: 10, keyword: "");
    vocabularyType??= VocabularyType.vocabularyList;
  }


  LessonListState copyWith({
    VocabularyResponseModel? vocabularyResponseModel,
    VocabularyStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    VocabularyType? vocabularyType,
    VocabularyInfo? selectVocabularyInfo
  })
  {
    return LessonListState(
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