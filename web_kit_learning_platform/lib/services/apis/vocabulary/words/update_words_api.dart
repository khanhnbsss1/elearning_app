import 'dart:convert';

import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import '../vocabulary_list/models/vocabulary_models.dart';

class UpdateWordsApi extends BaseApiRequest {
  VocabularyInfo word;
  UpdateWordsApi({required this.word}) : super(
      serviceType: SERVICE_TYPE.Vocabulary,
      apiName: ApiName().updateVocabulary,
  //  bodyMethod: BodyMethod.formData,
  );
  Future<dynamic> call() async {
    await getAuthorization();
    dynamic data = await putRequestAPI();
    if(data.runtimeType == String && (data as String).isEmpty)
      {
        ToastUtils.showToastSuccess(L10nX.getStr.success);
      }
    return data;
  }

  Future<void> getAuthorization() async {
    // TODO: implement getAuthorization
    await setApiBody(word.toJson());
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
