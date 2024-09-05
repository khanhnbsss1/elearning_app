import 'package:easy_localization/easy_localization.dart';
import '../../../../base/base_request_elearning/BaseApiRequest.dart';
import '../../../../base/widgets/toast_common/toast_utils.dart';

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
      ToastUtils.showToastSuccess('success'.tr());
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
