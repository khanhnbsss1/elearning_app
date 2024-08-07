part of 'create_edit_word_bloc.dart';

enum CreateEditWordStatus {
  initial,
  onUploadAudio,
  onUploadImage,
  onSubmit,
  onLoading,
  onError,
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
  List<TextEditingController>? exampleTextControllers = [];
  List<TextEditingController>? exampleMeaningControllers = [];
  List<TextEditingController>? exampleSimplifiedControllers = [];
  List<TextEditingController>? exampleSoundControllers = [];
  CreateEditWordState({
      this.blocStatus,
    this.documentModel,
    this.vocabularyInfo,
    this.image, 
    this.audio,
    this.addWordController,
    this.exampleMeaningControllers,
    this.exampleSimplifiedControllers,
    this.exampleSoundControllers,
    this.exampleTextControllers
  }){
    exampleTextControllers ??= [];
    exampleMeaningControllers ??= [];
    exampleSimplifiedControllers ??= [];
    exampleSoundControllers ??= [];
    addWordController ??= Get.put(AddWordController(vocabularyInfo: vocabularyInfo));
  }


  CreateEditWordState copyWith({
    CreateEditWordStatus? blocStatus,
    UploadFileResponseInfo? documentModel,
    VocabularyInfo? vocabularyInfo,
    UploadFileResponseInfo? audio,
    UploadFileResponseInfo? image,
    AddWordController? addWordController,
    List<TextEditingController>? exampleTextControllers,
    List<TextEditingController>? exampleMeaningControllers,
    List<TextEditingController>? exampleSimplifiedControllers,
    List<TextEditingController>? exampleSoundControllers,

  })
  {
    return CreateEditWordState(
      blocStatus: blocStatus??this.blocStatus,
      documentModel: documentModel??this.documentModel,
      vocabularyInfo: vocabularyInfo??this.vocabularyInfo,
      audio: audio??this.audio,
      image: image??this.image,
      addWordController: addWordController??this.addWordController,
      exampleTextControllers: exampleTextControllers??this.exampleTextControllers,
      exampleMeaningControllers: exampleMeaningControllers??this.exampleMeaningControllers,
      exampleSimplifiedControllers: exampleSimplifiedControllers??this.exampleSimplifiedControllers,
      exampleSoundControllers: exampleSoundControllers??this.exampleSoundControllers,

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
    exampleTextControllers,
    exampleMeaningControllers,
    exampleSimplifiedControllers,
    exampleSoundControllers
  ];

}