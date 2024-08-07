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