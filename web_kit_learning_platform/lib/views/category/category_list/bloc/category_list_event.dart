part of 'category_list_bloc.dart';

abstract class CategoryListEvent extends Equatable {
  const CategoryListEvent();
  @override
  List<Object?> get props => [];
}

class CategoryListInitEvent extends CategoryListEvent {
  CategoryListInitEvent();  
  @override
  List<Object?> get props => [];
}

class CategoryListOnSearchByFilterEvent extends CategoryListEvent {
  SearchCommonRequest searchCommonRequest;
  CategoryListOnSearchByFilterEvent({required this.searchCommonRequest} );
  @override
  List<Object?> get props => [searchCommonRequest];
}
class CategoryListOnSelectTagEvent extends CategoryListEvent {
  CategoryInfo selectInfo;
  CategoryListOnSelectTagEvent({required this.selectInfo} );
  @override
  List<Object?> get props => [selectInfo];
}
class CategoryListOnDeleteTagEvent extends CategoryListEvent {
  CategoryInfo selectInfo;
  CategoryListOnDeleteTagEvent({required this.selectInfo} );
  @override
  List<Object?> get props => [selectInfo];
}