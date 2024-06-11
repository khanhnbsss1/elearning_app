part of 'list_body_common_bloc.dart';

enum ListBodyCommonStatus {
  unKnown,
  initial,
  onDrag,
}

@immutable
class ListBodyCommonState extends Equatable {
  ListBodyCommonStatus blocStatus;
  double? dx = 0;
  double? widthOfListRatio;
  double? maxOfWidthOfListRatio = 0.5;
  double? minOfWidthOfListRatio = 0.05;
  double? widthOfPage  = 800;
  ListBodyCommonState({
      required this.blocStatus,
    this.widthOfListRatio,
    this.maxOfWidthOfListRatio,
    this.minOfWidthOfListRatio,
    this.dx,
    this.widthOfPage
  }){
    dx??=0;
    widthOfPage??=800;
  }


  ListBodyCommonState copyWith({
    ListBodyCommonStatus? blocStatus,
    double? dx,
    double? widthOfListRatio,
    double? maxOfWidthOfListRatio,
    double? minOfWidthOfListRatio,
    double? widthOfPage
  })
  {
    return ListBodyCommonState(
      blocStatus: blocStatus??this.blocStatus,
      dx: dx??this.dx,
      widthOfListRatio: widthOfListRatio??this.widthOfListRatio,
      maxOfWidthOfListRatio: maxOfWidthOfListRatio??this.maxOfWidthOfListRatio,
      minOfWidthOfListRatio: minOfWidthOfListRatio??this.minOfWidthOfListRatio,
      widthOfPage: widthOfPage??this.widthOfPage,
    );
  }
  @override
  List<Object?> get props => [blocStatus, dx, minOfWidthOfListRatio, maxOfWidthOfListRatio, widthOfListRatio, widthOfPage];

}