part of 'grade_list_bloc.dart';

abstract class GradeListEvent extends Equatable {
  const GradeListEvent();
  @override
  List<Object?> get props => [];
}

class GradeListInitEvent extends GradeListEvent {
  GradeListInitEvent();  
  @override
  List<Object?> get props => [];
}

class GradeListOnSearchByFilterEvent extends GradeListEvent {
  SearchCommonRequest searchCommonRequest;
  GradeListOnSearchByFilterEvent({required this.searchCommonRequest} );
  @override
  List<Object?> get props => [searchCommonRequest];
}
class TagListOnSelectTagEvent extends GradeListEvent {
  GradeInfo selectTagInfo;
  TagListOnSelectTagEvent({required this.selectTagInfo} );
  @override
  List<Object?> get props => [selectTagInfo];
}
class GradeListOnDeleteTagEvent extends GradeListEvent {
  GradeInfo selectTagInfo;
  GradeListOnDeleteTagEvent({required this.selectTagInfo} );
  @override
  List<Object?> get props => [selectTagInfo];
}