
import 'package:lms_app/base/widgets/toast_common/toast_utils.dart';

import '../../../base/base_request_elearning/BaseApiRequest.dart';
import 'models/rating_info.dart';

class DeleteRatingApi extends BaseApiRequest {
  RatingInfo info;
  DeleteRatingApi({required this.info}):super(
    serviceType: SERVICE_TYPE.Rating,
    apiName: ApiName.getInstance().deleteRating,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await deleteRequestAPI();
    return result;
  }

  Future<void> getAuthorization() async {
    await setParamsAdd({"ratingId":info.id,});
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
