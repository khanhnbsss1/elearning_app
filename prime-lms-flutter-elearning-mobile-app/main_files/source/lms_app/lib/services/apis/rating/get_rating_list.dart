
import '../../../base/base_request_elearning/BaseApiRequest.dart';
import '../../../base/base_request_elearning/models/search_common_request.dart';
import 'models/rating_info.dart';

class GetRatingListApi extends BaseApiRequest {
  SearchCommonRequest searchCommonRequest;
  GetRatingListApi({required this.searchCommonRequest}):super(
    serviceType: SERVICE_TYPE.Rating,
    apiName: ApiName.getInstance().getRatingList,
  );

  Future<RatingListResponseModel> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return RatingListResponseModel(content: [], total: 0, pageSize: 20, pageNumber: 0);
    }
    else
    {
      RatingListResponseModel model = RatingListResponseModel.fromJson(result);
      return model;
    }
  }

  Future<void> getAuthorization() async {
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
