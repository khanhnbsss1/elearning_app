import '../../../../base/base_request_elearning/BaseApiRequest.dart';
import '../vocabulary_list/models/vocabulary_models.dart';

class GetVocabularyDetailApi extends BaseApiRequest {
  int vocabularyId;
  GetVocabularyDetailApi({required this.vocabularyId}):super(
    serviceType: SERVICE_TYPE.VOCABULARY,
    apiName: ApiName.getInstance().getVocabularyDetail,
  );

  Future<VocabularyInfo?> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();
    if(result.runtimeType!=ResponseCommon)
      {
        VocabularyInfo vocabularyInfo = VocabularyInfo.fromJson(result.first);
        return vocabularyInfo;
      }
    else
      {
        return null;
      }
  }

  Future<void> getAuthorization() async {
    await setParamsAdd({"vocabularyId":vocabularyId});
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
