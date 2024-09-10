part of 'create_edit_word_bloc.dart';

enum CreateEditWordStatus {
  initial,
  onUploadAudio,
  onUploadImage,
  onSubmit,
  onLoading,
  onError,
  onSaveSentence,
  onCreateNewSentence,
  onUpdateWord,
  onUpdateWordInfo,
  onChangeMode,
  onUpdateMultiVocabulary,
  onUpdateMultiVocabularyAudio,
  onUploadMultiVocabulary,
  unknown
}

@immutable
class CreateEditWordState extends Equatable {
  CreateEditWordStatus? blocStatus;
  UploadFileResponseInfo? documentModel;
  VocabularyInfo? vocabularyInfo;
  List<VocabularyInfo>? listMultiVocabularyInfo;
  UploadFileResponseInfo? audio;
  UploadFileResponseInfo? image;
  AddWordController? addWordController;
  WordsPageActionType? wordsPageActionType;
  FilePickerResult? listMultiVocabularyInfoAudio;
  int? exampleIndex =0;
  bool? isAddMultiWord = false;
  CreateEditWordState({
      this.blocStatus,
    this.documentModel,
    this.vocabularyInfo,
    this.image, 
    this.audio,
    this.addWordController,
    this.wordsPageActionType,
    this.exampleIndex,
    this.isAddMultiWord,
    this.listMultiVocabularyInfo,
    this.listMultiVocabularyInfoAudio
  }){
    exampleIndex??=-1;
    isAddMultiWord??=false;
    listMultiVocabularyInfo??=[];
    if(wordsPageActionType == WordsPageActionType.view)
      {
        vocabularyInfo??=VocabularyInfo(sentenceInfos: []);
        vocabularyInfo?.sentenceInfos =[];
      }
    else
      {
        vocabularyInfo??=VocabularyInfo();
      }
    addWordController ??= AddWordController(vocabularyInfo: vocabularyInfo);
  }


  CreateEditWordState copyWith({
    CreateEditWordStatus? blocStatus,
    UploadFileResponseInfo? documentModel,
    VocabularyInfo? vocabularyInfo,
    UploadFileResponseInfo? audio,
    UploadFileResponseInfo? image,
    AddWordController? addWordController,
    WordsPageActionType? wordsPageActionType,
    int? exampleIndex,
    bool? isAddMultiWord,
    List<VocabularyInfo>? listMultiVocabularyInfo,
    FilePickerResult? listMultiVocabularyInfoAudio
  })
  {
    return CreateEditWordState(
      blocStatus: blocStatus??this.blocStatus,
      documentModel: documentModel??this.documentModel,
      vocabularyInfo: vocabularyInfo??this.vocabularyInfo,
      audio: audio??this.audio,
      image: image??this.image,
      addWordController: addWordController??this.addWordController,
      wordsPageActionType: wordsPageActionType??this.wordsPageActionType,
      exampleIndex: exampleIndex??this.exampleIndex,
      isAddMultiWord: isAddMultiWord??this.isAddMultiWord,
      listMultiVocabularyInfo: listMultiVocabularyInfo??this.listMultiVocabularyInfo,
      listMultiVocabularyInfoAudio: listMultiVocabularyInfoAudio??this.listMultiVocabularyInfoAudio,


    );
  }
  @override
  List<Object?> get props => [
    blocStatus, 
    documentModel, 
    vocabularyInfo, 
    image, 
    audio,
    addWordController,
    wordsPageActionType,
    exampleIndex,
    isAddMultiWord,
    listMultiVocabularyInfo,
    listMultiVocabularyInfoAudio
  ];

}