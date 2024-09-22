
import '../../../base/base_request_elearning/BaseApiRequest.dart';
import '../../../base/widgets/toast_common/toast_utils.dart';
import '../../../l10n/l10n_extention.dart';
import 'models/rating_info.dart';

class AddRatingApi extends BaseApiRequest {
  RatingInfo info;
  AddRatingApi({required this.info}):super(
    serviceType: SERVICE_TYPE.Rating,
    apiName: ApiName.getInstance().addRating,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();
    if(result.runtimeType == String && (result as String).isEmpty)
    {
      ToastUtils.showToastSuccess('success');
    }
    return result;
  }

  Future<void> getAuthorization() async {
    await setApiBody(info.toJson());
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
