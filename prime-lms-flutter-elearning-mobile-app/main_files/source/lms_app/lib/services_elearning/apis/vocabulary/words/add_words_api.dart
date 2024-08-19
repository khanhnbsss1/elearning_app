
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
import '../vocabulary_list/models/vocabulary_models.dart';

class AddWordsApi extends BaseApiRequest {
  VocabularyInfo word;
  AddWordsApi({required this.word}) : super(
      serviceType: SERVICE_TYPE.Vocabulary,
      apiName: ApiName().addVocabulary,
   // bodyMethod: BodyMethod.formData,
  );
  Future<dynamic> call() async {
    await getAuthorization();
    dynamic data = await postRequestAPI();
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
