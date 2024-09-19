
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';

class DeleteAllWordApi extends BaseApiRequest {
  VocabularyType info;
  DeleteAllWordApi({required this.info}):super(
    serviceType: SERVICE_TYPE.VOCABULARY,
    apiName: ApiName.getInstance().deleteAllVocabulary,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await deleteRequestAPI();
    return result;
  }

  Future<void> getAuthorization() async {
    await setParamsAdd(
        {
          "type":info== VocabularyType.vocabularyImage? "Image":"NoImage"
        }
    );
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
