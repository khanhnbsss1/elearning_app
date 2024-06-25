part of 'review_list_bloc.dart';

enum ReviewListStatus {
  onLoading, 
  initial,
  onExpand
}

@immutable
class ReviewListState extends Equatable {
  ReviewListStatus? blocStatus;
  CourseListLandingPageResponseModel? courseListLandingPageResponseModel;
  bool? isExpand;
  ReviewListState({
      this.blocStatus,
    this.courseListLandingPageResponseModel,
    this.isExpand
  });


  ReviewListState copyWith({
    ReviewListStatus? blocStatus,
    CourseListLandingPageResponseModel? courseListLandingPageResponseModel,
    bool? isExpand
  })
  {
    return ReviewListState(
      blocStatus: blocStatus??this.blocStatus,
      courseListLandingPageResponseModel: courseListLandingPageResponseModel??this.courseListLandingPageResponseModel,
      isExpand: isExpand??this.isExpand,

    );
  }
  @override
  List<Object?> get props => [blocStatus, courseListLandingPageResponseModel, isExpand];

}