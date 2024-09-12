
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/category/models/category_info.dart';
import 'package:webkit/services/apis/rating/models/rating_info.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';


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
      ToastUtils.showToastSuccess(L10nX.getStr.success);
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
