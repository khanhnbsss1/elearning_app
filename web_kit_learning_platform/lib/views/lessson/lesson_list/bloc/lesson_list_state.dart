part of 'lesson_list_bloc.dart';

enum LessonListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
  onSelectLesson
}

@immutable
class LessonListState extends Equatable {
  LessonListResponseModel? lessonListResponseModel;
  LessonListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  LessonInfo? selectLessonInfo;
  LessonListState({
      this.blocStatus, 
    this.lessonListResponseModel,
    this.searchCommonRequest,
    this.selectLessonInfo
  }){
    lessonListResponseModel??= LessonListResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(pageNumber: 0, pageSize: 10, keyword: "");
  }


  LessonListState copyWith({
    LessonListResponseModel? lessonListResponseModel,
    LessonListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    LessonInfo? selectLessonInfo
  })
  {
    return LessonListState(
      blocStatus: blocStatus??this.blocStatus,
      lessonListResponseModel: lessonListResponseModel??this.lessonListResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectLessonInfo: selectLessonInfo??this.selectLessonInfo,

    );
  }
  @override
  List<Object?> get props => [blocStatus, lessonListResponseModel, searchCommonRequest, selectLessonInfo];

}