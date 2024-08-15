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
  unknown
}

@immutable
class CreateEditWordState extends Equatable {
  CreateEditWordStatus? blocStatus;
  UploadFileResponseInfo? documentModel;
  VocabularyInfo? vocabularyInfo;
  UploadFileResponseInfo? audio;
  UploadFileResponseInfo? image;
  AddWordController? addWordController;
  WordsPageActionType? wordsPageActionType;
  CreateEditWordState({
      this.blocStatus,
    this.documentModel,
    this.vocabularyInfo,
    this.image, 
    this.audio,
    this.addWordController,
    this.wordsPageActionType,
  }){
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
    WordsPageActionType? wordsPageActionType
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
  ];

}