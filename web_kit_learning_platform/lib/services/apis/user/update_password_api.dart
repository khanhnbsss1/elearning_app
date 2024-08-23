
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';


class UpdateUpdatePasswordApi extends BaseApiRequest {
  String userName;
  String oldpassword;
  String newpassword;

  UpdateUpdatePasswordApi({required this.userName, required this.newpassword, required this.oldpassword}):super(
    serviceType: SERVICE_TYPE.AUTHEN,
    apiName: ApiName.getInstance().updatePassword,
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
    await setApiBody({
      "username":userName,
      "oldpassword":oldpassword,
      "newpassword":newpassword
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
