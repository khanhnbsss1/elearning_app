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
  onCheckAudio,
  onChangePage,
  onUpdateUploadProgress,
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
  SearchCommonRequest? searchCommonRequestListMultiVocabularyInfo;
  List<VocabularyInfo>? listMultiVocabularyInfoForView;
  double? progress;
  bool? uploading;
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
    this.listMultiVocabularyInfoAudio,
    this.searchCommonRequestListMultiVocabularyInfo,
    this.listMultiVocabularyInfoForView,
    this.progress,
    this.uploading
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
    searchCommonRequestListMultiVocabularyInfo??=SearchCommonRequest(pageNumber: 1, pageSize: 20, );
    listMultiVocabularyInfoForView??=[];
    progress??=0;
    uploading??=false;
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
    FilePickerResult? listMultiVocabularyInfoAudio,
    SearchCommonRequest? searchCommonRequestListMultiVocabularyInfo,
    List<VocabularyInfo>? listMultiVocabularyInfoForView,
    double? progress,
    bool? uploading
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
      searchCommonRequestListMultiVocabularyInfo: searchCommonRequestListMultiVocabularyInfo??this.searchCommonRequestListMultiVocabularyInfo,
      listMultiVocabularyInfoForView: listMultiVocabularyInfoForView??this.listMultiVocabularyInfoForView,
      progress: progress??this.progress,
      uploading: uploading??this.uploading,


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
    listMultiVocabularyInfoAudio,
    searchCommonRequestListMultiVocabularyInfo,
    listMultiVocabularyInfoForView,
    progress,
    uploading
  ];

}