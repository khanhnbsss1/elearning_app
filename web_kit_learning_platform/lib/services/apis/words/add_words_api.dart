import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/device/device_manager.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/EnumCommon.dart';
import 'package:webkit/base/services/base_request/apiName.dart';
import 'package:webkit/base/services/base_request/models/response_error_objects.dart';
import 'package:webkit/services/apis/words/word_model.dart';
import 'package:webkit/views/course/course_list/add_words.dart';

class AddWordsApi extends BaseApiRequest {
  Word word;
  AddWordsApi({required this.word})
      : super(
      serviceType: SERVICE_TYPE.Vocabulary,
      apiName: ApiName.getInstance().addWord,
    requestBody: {
        'data': {
          'simplified':word.simplified,
          'traditional':word.traditional,
          'pinyin_tones':word.pinyinTones,
          'translation_vn':word.translationVn,
          'created_by':'long1'
        },
        'audio': word.audio,
    }
  );
  Future<dynamic> call() async {
    await getAuthorization();
    dynamic data = await postRequestAPI();
  }

  Future<void> getAuthorization() async {
    // TODO: implement getAuthorization
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
