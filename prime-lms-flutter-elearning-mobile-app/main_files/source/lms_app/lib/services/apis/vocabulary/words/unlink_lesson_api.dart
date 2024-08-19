import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';

class UnLinkWordApi extends BaseApiRequest {
  List<VocabularyInfo> vocabularyInfos;
  int lessonId;
  UnLinkWordApi({required this.vocabularyInfos, required this.lessonId,}):super(
    serviceType: SERVICE_TYPE.LESSON,
    apiName: ApiName.getInstance().unlinkVocabulary,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      ToastUtils.showToastError((result as ResponseCommon).message??"");
      return null;
    }
    else
    {
      return result;
    }
  }

  Future<void> getAuthorization() async {
    String listId = vocabularyInfos.map((e) => e.id,).toList().join(',');
    await setApiBody({
      "vocabularyIds":listId,
      "lectureId":lessonId,
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
