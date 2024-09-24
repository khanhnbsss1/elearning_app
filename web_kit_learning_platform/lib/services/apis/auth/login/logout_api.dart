import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/device/device_manager.dart';
import 'package:webkit/base/instance_mananger/filter_manager.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/widgets/biomectric/IdentifierConst.dart';
import 'package:webkit/services/apis/user/get_user_detail_api.dart';
import 'models/login_request.dart';
import 'models/login_response.dart';

class LoginOutApi extends BaseApiRequest {
  LoginOutApi()
      : super(
      serviceType: SERVICE_TYPE.AUTHEN,
      apiName: ApiName.getInstance().logout,
      isCheckToken: false,
      isShowErrorPopup: false,
    isShowToastError: false
  );
  Future<dynamic> call() async {
    await getAuthorization();
    dynamic data = await postRequestAPI();
    return data;
  }
  Future<void> getAuthorization() async {
    DeviceInfoModel? deviceInfoModel = await DeviceManager().getDeviceInfo();
    AuthInfo? authInfo = AuthorManager().getAuthInfo();

    if(deviceInfoModel!=null && authInfo!=null && (authInfo.refreshToken??"").isNotEmpty)
      {
        await setApiBody({
          "refreshToken":authInfo.refreshToken,
          "type":deviceInfoModel.type
        });
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
