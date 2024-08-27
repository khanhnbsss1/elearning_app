
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
import '../../../../base/author/user_helper.dart';
import '../../../../base/base_request_elearning/models/search_common_request.dart';
import '../../../../models/user/UserProfile.dart';
import 'models/vocabulary_models.dart';

class GetListVocabularyApi extends BaseApiRequest {
  SearchCommonRequest searchCommonRequest;
  GetListVocabularyApi({required this.searchCommonRequest}):super(
    serviceType: SERVICE_TYPE.VOCABULARY,
    apiName: ApiName.getInstance().getListVocabulary,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return VocabularyResponseModel(content: [], total: 0, pageSize: 0, pageNumber: 0);
    }
    else
    {
      VocabularyResponseModel vocabularyResponseModel = VocabularyResponseModel.fromJson(result);
      return vocabularyResponseModel;
    }
  }

  Future<void> getAuthorization() async {
    UserProfile? userProfile = await UserManager().getUserProfile();
    if(userProfile!=null) {
      searchCommonRequest = searchCommonRequest.copyWith(userId: userProfile.id);
    }
     await setApiBody(searchCommonRequest.toJson());
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
