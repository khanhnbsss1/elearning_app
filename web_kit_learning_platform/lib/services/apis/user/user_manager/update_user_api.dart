
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';


class UpdateUserApi extends BaseApiRequest {
  UserProfile info;
  UpdateUserApi({required this.info}):super(
    serviceType: SERVICE_TYPE.USER,
    apiName: ApiName.getInstance().editUser,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await putRequestAPI();
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
