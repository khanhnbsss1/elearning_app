import 'dart:convert';

import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/words/word_model.dart';

class AddWordsApi extends BaseApiRequest {
  WordInfo word;
  AddWordsApi({required this.word}) : super(
      serviceType: SERVICE_TYPE.Vocabulary,
      apiName: ApiName().addVocabulary,
    bodyMethod: BodyMethod.formData,
  );
  Future<dynamic> call() async {
    await getAuthorization();
    dynamic data = await postRequestAPI();
    return data;
  }

  Future<void> getAuthorization() async {
    // TODO: implement getAuthorization
    await setApiBody({
      'data': jsonEncode({
        'simplified':word.simplified,
        'traditional':word.traditional,
        'pinyin_tones':word.pinyinTones,
        'translation_vn':word.translationVn,
        'created_by':'long1'
      }),
      'audio': word.audio,
    });
  }

  @override
  Future<void> onRequestSuccess(var data) async {
    // TODO: implement onRequestSuccess
    super.onRequestSuccess(data);
  }

  @override
  Future<void> onRequestError(int? statusCode, String? statusMessage) async{
    // TODO: implement onRequestError
    super.onRequestError(statusCode, statusMessage);
  }
}
