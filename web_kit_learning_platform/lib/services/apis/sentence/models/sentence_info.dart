import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';

class SentenceInfo {
  int? id;
  String? chineseSentence;
  String? pinyionSentence;
  String? translationVn;
  String? audioLink;
  int? audioId;
  UploadFileResponseInfo? audioFileInfo;
  String? audioName;
  bool?isMapAudio;
  SentenceInfo(
      {
        this.id,
        this.chineseSentence,
        this.pinyionSentence,
        this.translationVn,
        this.audioLink,
        this.audioId,
        this.audioFileInfo,
        this.audioName,
        this.isMapAudio
      }){
    isMapAudio??=false;
    chineseSentence??='';
    pinyionSentence??='';
    translationVn??='';
    audioLink??='';
  }


  SentenceInfo copyWith({
    int? id,
    String? chineseSentence,
    String? pinyionSentence,
    String? translationVn,
    String? audioLink,
    int? audioId,
    UploadFileResponseInfo? audioFileInfo,
    String? audioName
  })
  {
    return SentenceInfo(
      id: id??this.id,
      chineseSentence: chineseSentence??this.chineseSentence,
      pinyionSentence: pinyionSentence??this.pinyionSentence,
      audioLink: audioLink??this.audioLink,
      audioId: audioId??this.audioId,
      audioFileInfo: audioFileInfo??this.audioFileInfo,
      audioName: audioName??this.audioName,
    );
  } 
  
  SentenceInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chineseSentence = json['chinese_sentence'];
    pinyionSentence = json['pinyin_sentence'];
    translationVn = json['translationvn_sentence'];
    audioLink = json['audio_link'];
    audioId = json['audio_id'];
    audioName = json['audioName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if((id??-1)>0)
      {
      //  data['id']=id;
    }
    data['chinese_sentence']=chineseSentence;
    data['pinyin_sentence']=pinyionSentence;
    data['pinyion_sentence']=pinyionSentence;
    data['translationvn_sentence']=translationVn;
    data['audio_link']=audioLink;
    data['audio_sentence']=audioLink;
    data['audio_id']=audioId;
    return data;
  }
  bool isValidate(){
    return chineseSentence!.isNotEmpty && pinyionSentence!.isNotEmpty && translationVn!.isNotEmpty;
  }
}
