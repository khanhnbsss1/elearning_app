part of 'course_detail_bloc.dart';

enum AddCourseStatus {
  onLoading,
  initial,
  onLoadingSelectLesson,
  onSelectLesson,
  onUpdateSelectionLesson,
  onSelectionCurrentVideo,
  onUpdateFinishVideoStatus,
  onUpdateFinishLessonStatus,
  getRatingList, 
  onChangeRating, 
  onRating,
  onSubmitRating,
  unKnown
}

@immutable
class CourseDetailState extends Equatable {
  AddCourseStatus? blocStatus;
  CourseInfo? courseInfo;
  List<String>? courseObject = [];
  List<String>? courseResult = [];
  LessonInfo? selectLessonInfo;
  List<bool>? showSubject = [];
  List<List<bool>>?checkLecture = [];
  bool? awaitCallApi;
  SearchCommonRequest? searchCommonRequestRating;
  RatingListResponseModel? ratingListResponseModel;
  RatingState? ratingState = RatingState.notRating;
  double? myRate ;
  CourseDetailState({
    this.blocStatus,
    this.courseInfo,
    this.courseObject,
    this.courseResult,
    this.selectLessonInfo,
    this.checkLecture,
    this.showSubject,
    this.awaitCallApi,
    this.searchCommonRequestRating,
    this.ratingListResponseModel,
    this.ratingState,
    this.myRate

  }){
    courseInfo??=CourseInfo.initial();
    checkLecture??=[];
    showSubject??=[];
    awaitCallApi??=false;
    searchCommonRequestRating??=SearchCommonRequest(courseId: courseInfo?.id,pageSize: 20,pageNumber: 0, keyword: "");
    ratingListResponseModel??= RatingListResponseModel(content: []);
    ratingState ??= RatingState.notRating;
    myRate??=0;
  }


  CourseDetailState copyWith({
    AddCourseStatus? blocStatus,
    CourseInfo? courseInfo,
    List<String>? courseObject,
    List<String>? courseResult,
    LessonInfo? selectLessonInfo, 
    List<bool>? showSubject, 
    List<List<bool>>?checkLecture ,
    SearchCommonRequest? searchCommonRequestRating,
    RatingListResponseModel? ratingListResponseModel,
    RatingState? ratingState,
    double? myRate
  })
  {
    return CourseDetailState(
      blocStatus: blocStatus??this.blocStatus,
         courseInfo: courseInfo??this.courseInfo,
      courseObject: courseObject??this.courseObject,
      courseResult: courseResult??this.courseResult,
      selectLessonInfo: selectLessonInfo??this.selectLessonInfo,
      showSubject: showSubject??this.showSubject,
      checkLecture: checkLecture??this.checkLecture,
      searchCommonRequestRating: searchCommonRequestRating??this.searchCommonRequestRating,
      ratingListResponseModel: ratingListResponseModel??this.ratingListResponseModel,
      ratingState: ratingState??this.ratingState,
      myRate: myRate??this.myRate,

    );
  }
  @override
  List<Object?> get props => [
    blocStatus, 
    courseInfo,
    courseObject,
    courseResult,
    selectLessonInfo,
    showSubject,
    checkLecture,
    searchCommonRequestRating,
    ratingListResponseModel,
    ratingState,
    myRate
  ];

}

