
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';

import '../models/landing_page_review_list_response_model.dart';


class DeleteReviewApi extends BaseApiRequest {
  ReviewLandingPageInfo info;
  DeleteReviewApi({required this.info}):super(
    serviceType: SERVICE_TYPE.LandingPages,
    apiName: ApiName.getInstance().deleteLandingPageReview,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await deleteRequestAPI();
    return result;
  }

  Future<void> getAuthorization() async {
    await setParamsAdd({
      "reviewId": info.id
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
