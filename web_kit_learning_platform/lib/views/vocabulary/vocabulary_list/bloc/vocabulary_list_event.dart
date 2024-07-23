part of 'vocabulary_list_bloc.dart';

abstract class VocabularyListEvent extends Equatable {
  const VocabularyListEvent();
  @override
  List<Object?> get props => [];
}

class VocabularyListInitEvent extends VocabularyListEvent {
  VocabularyListInitEvent();  
  @override
  List<Object?> get props => [];
}
class VocabularyListOnSearchByFilterEvent extends VocabularyListEvent {
  SearchCommonRequest searchCommonRequest;
  VocabularyListOnSearchByFilterEvent({required this.searchCommonRequest} );
  @override
  List<Object?> get props => [searchCommonRequest];
}
class VocabularyListOnSelectVocabularyEvent extends VocabularyListEvent {
  VocabularyInfo selectVocabularyInfo;
  VocabularyListOnSelectVocabularyEvent({required this.selectVocabularyInfo} );
  @override
  List<Object?> get props => [selectVocabularyInfo];
}