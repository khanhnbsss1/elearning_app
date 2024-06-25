part of 'review_list_bloc.dart';

abstract class ReviewListEvent extends Equatable {
  const ReviewListEvent();
  @override
  List<Object?> get props => [];
}

class ReviewListInitEvent extends ReviewListEvent {
  ReviewListInitEvent(); 
  @override
  List<Object?> get props => [];
}
class ReviewListOnExpandEvent extends ReviewListEvent {
  bool isExpand; 
  ReviewListOnExpandEvent({required this.isExpand});
  @override
  List<Object?> get props => [isExpand];
}