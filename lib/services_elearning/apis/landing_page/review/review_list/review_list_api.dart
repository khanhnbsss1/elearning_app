import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/landing_page/review/models/landing_page_review_list_response_model.dart';

class LandingPageReviewListApi extends BaseApiRequest {
  UserTypeName? typeName;
  LandingPageReviewListApi({this.typeName}):super(
    serviceType: SERVICE_TYPE.LandingPages,
    apiName: ApiName.getInstance().getReviewListLandingPage,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();
    if(result.runtimeType == ResponseCommon)
    {
      return ReviewListLandingPageResponseModel(data: []);
    }
    else
    {
      ReviewListLandingPageResponseModel paymentHistoryResponseModel = ReviewListLandingPageResponseModel.fromJsonList(result);
      return paymentHistoryResponseModel;
    }
  }

  Future<void> getAuthorization() async {
    if(typeName!=null)
      {
        await setParamsAdd({"type": typeNameToStr[typeName]});
      }
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
