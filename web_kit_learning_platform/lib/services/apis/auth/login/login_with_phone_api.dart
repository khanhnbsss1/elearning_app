import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/device/device_manager.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/EnumCommon.dart';
import 'package:webkit/base/services/base_request/apiName.dart';
import 'package:webkit/base/services/base_request/models/response_error_objects.dart';
import 'package:webkit/base/store/store.exports.dart';
import 'package:webkit/base/widgets/biomectric/IdentifierConst.dart';
import 'login_request.dart';
import 'login_response.dart';

class LoginWithPhoneApi extends BaseApiRequest {
  LoginRequest loginRequest;
  LoginWithPhoneApi({required this.loginRequest})
      : super(
      serviceType: SERVICE_TYPE.AUTHEN,
      apiName: ApiName.getInstance().loginByPhone,
      requestBody: loginRequest.toJson(),
      isCheckToken: false,
      isShowErrorPopup: false
  );
  Future<dynamic> call() async {
    await getAuthorization();
    dynamic data = await postRequestAPI();
   if(data!=null && data.runtimeType !=ResponseCommon)
     {
       LoginResponse loginResponse = LoginResponse.fromJson(data);
       await UserHelper.getInstance.handleLogoutData();
       DataAccess.saveAccountLoginNearest(IdentifierConst.username);
       return true;
     }
   else
     {
       return false;
     }
  }
  Future<void> getAuthorization() async {
    DeviceInfoModel? deviceInfoModel = await DeviceManager().getDeviceInfo();
    if(deviceInfoModel!=null)
      {
        loginRequest.serialNumber = deviceInfoModel.serialNumber;
        loginRequest.type = deviceInfoModel.type;
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
