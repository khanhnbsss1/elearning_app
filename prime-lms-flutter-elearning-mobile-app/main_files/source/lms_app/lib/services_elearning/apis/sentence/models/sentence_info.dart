import 'package:lms_app/services_elearning/apis/upload_file/models/upload_file_info.dart';

class SentenceInfo {
  int? id;
  String? chineseSentence;
  String? pinyionSentence;
  String? translationVn;
  String? audioLink;
  int? audioId;
  UploadFileResponseInfo? audioFileInfo;
  SentenceInfo(
      {
        this.id,
        this.chineseSentence,
        this.pinyionSentence,
        this.translationVn,
        this.audioLink,
        this.audioId,
        this.audioFileInfo
      }){
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
  })
  {
    return SentenceInfo(
      id: id??this.id,
      chineseSentence: chineseSentence??this.chineseSentence,
      pinyionSentence: pinyionSentence??this.pinyionSentence,
      audioLink: audioLink??this.audioLink,
      audioId: audioId??this.audioId,
      audioFileInfo: audioFileInfo??this.audioFileInfo,
    );
  } 
  
  SentenceInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chineseSentence = json['chinese_sentence'];
    pinyionSentence = json['pinyion_sentence'];
    translationVn = json['translation_vn'];
    audioLink = json['audio_link'];
    audioId = json['audio_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['id']=id;
    data['chinese_sentence']=chineseSentence;
    data['pinyion_sentence']=pinyionSentence;
    data['translationvn_sentence']=translationVn;
    data['audio_link']=audioLink;
    data['audio_sentence']=audioLink;
    data['audio_id']=audioId;
    return data;
  }
  bool isValidate(){
    return chineseSentence!.isNotEmpty && pinyionSentence!.isNotEmpty && translationVn!.isNotEmpty && audioLink!.isNotEmpty;
  }
}
