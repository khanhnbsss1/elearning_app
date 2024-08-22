part of 'tag_list_bloc.dart';

abstract class TagListEvent extends Equatable {
  const TagListEvent();
  @override
  List<Object?> get props => [];
}

class TagListInitEvent extends TagListEvent {
  TagListInitEvent();  
  @override
  List<Object?> get props => [];
}

class TagListOnSearchByFilterEvent extends TagListEvent {
  SearchCommonRequest searchCommonRequest;
  TagListOnSearchByFilterEvent({required this.searchCommonRequest} );
  @override
  List<Object?> get props => [searchCommonRequest];
}
class TagListOnSelectTagEvent extends TagListEvent {
  TagsInfo selectTagInfo;
  TagListOnSelectTagEvent({required this.selectTagInfo} );
  @override
  List<Object?> get props => [selectTagInfo];
}
class TagListOnDeleteTagEvent extends TagListEvent {
  TagsInfo selectTagInfo;
  TagListOnDeleteTagEvent({required this.selectTagInfo} );
  @override
  List<Object?> get props => [selectTagInfo];
}