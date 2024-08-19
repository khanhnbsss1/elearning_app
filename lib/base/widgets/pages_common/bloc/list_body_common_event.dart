part of 'list_body_common_bloc.dart';

class ListBodyCommonEvent extends Equatable {
  const ListBodyCommonEvent();
  @override
  List<Object?> get props => [];
}

class ListBodyCommonInitEvent extends ListBodyCommonEvent {
  const ListBodyCommonInitEvent();
  @override
  List<Object?> get props => [];
}

class ListBodyCommonDragEvent extends ListBodyCommonEvent {
  double dx;
  ListBodyCommonDragEvent({required this.dx});
  @override
  List<Object?> get props => [dx];
}