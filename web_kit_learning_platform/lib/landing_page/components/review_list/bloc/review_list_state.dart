part of 'review_list_bloc.dart';

enum ReviewListStatus {
  onLoading, 
  initial,
  onExpand
}

@immutable
class ReviewListState extends Equatable {
  ReviewListStatus? blocStatus;
  UserTypeName? typeName;
  ReviewListLandingPageResponseModel? reviewListLandingPageResponseModel;
  bool? isExpand;
  ReviewListState({
      this.blocStatus,
    this.reviewListLandingPageResponseModel,
    this.isExpand,
    this.typeName
  });


  ReviewListState copyWith({
    ReviewListStatus? blocStatus,
    ReviewListLandingPageResponseModel? reviewListLandingPageResponseModel,
    bool? isExpand,
    UserTypeName? typeName
  })
  {
    return ReviewListState(
      blocStatus: blocStatus??this.blocStatus,
      reviewListLandingPageResponseModel: reviewListLandingPageResponseModel??this.reviewListLandingPageResponseModel,
      isExpand: isExpand??this.isExpand,
      typeName: typeName??this.typeName,
    );
  }
  @override
  List<Object?> get props => [blocStatus, reviewListLandingPageResponseModel, isExpand, typeName];

}