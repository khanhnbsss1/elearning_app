part of 'create_edit_word_bloc.dart';

abstract class CreateEditWordEvent extends Equatable {
  const CreateEditWordEvent();
  @override
  List<Object?> get props => [];
}

class CreateEditWordInitEvent extends CreateEditWordEvent {
  CreateEditWordInitEvent();
  @override
  List<Object?> get props => [];
}
class CreateEditWordUploadAudioEvent extends CreateEditWordEvent {
  UploadFileInfo data; 
  CreateEditWordUploadAudioEvent({required this.data});
  @override
  List<Object?> get props => [data];
}

class CreateEditWordUploadImageEvent extends CreateEditWordEvent {
  UploadFileInfo data;
  CreateEditWordUploadImageEvent({required this.data});
  @override
  List<Object?> get props => [data];
}

class CreateEditWordCreateWordEvent extends CreateEditWordEvent {
  CreateEditWordState state;
  CreateEditWordCreateWordEvent({required this.state});
  @override
  List<Object?> get props => [state];
}

class CreateEditWordUpdateWordEvent extends CreateEditWordEvent {
  CreateEditWordState state;
  CreateEditWordUpdateWordEvent({required this.state});
  @override
  List<Object?> get props => [state];
}
class CreateEditWordOnSaveSentenceEvent extends CreateEditWordEvent {
  SentenceInfo sentenceInfo;
  CreateEditWordOnSaveSentenceEvent({required this.sentenceInfo});
  @override
  List<Object?> get props => [sentenceInfo];
}

class CreateEditWordOnAddNewSentenceEvent extends CreateEditWordEvent {
  CreateEditWordOnAddNewSentenceEvent();
  @override
  List<Object?> get props => [];
}

class CreateEditWordOnRemoveSentenceEvent extends CreateEditWordEvent {
  SentenceInfo sentenceInfo;
  CreateEditWordOnRemoveSentenceEvent({required this.sentenceInfo});
  @override
  List<Object?> get props => [sentenceInfo];
}
class CreateEditWordOnUpdateVocabularyInfoEvent extends CreateEditWordEvent {
  VocabularyInfo vocabularyInfo;
  CreateEditWordOnUpdateVocabularyInfoEvent({required this.vocabularyInfo});
  @override
  List<Object?> get props => [vocabularyInfo];
}