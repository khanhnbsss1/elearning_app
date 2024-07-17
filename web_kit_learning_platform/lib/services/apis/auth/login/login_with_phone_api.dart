import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/device/device_manager.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/EnumCommon.dart';
import 'package:webkit/base/services/base_request/apiName.dart';
import 'package:webkit/base/services/base_request/models/response_error_objects.dart';
import 'package:webkit/base/store/store.exports.dart';
import 'package:webkit/base/widgets/biomectric/IdentifierConst.dart';
import 'package:webkit/services/apis/user/get_user_detail_api.dart';
import 'models/login_request.dart';
import 'models/login_response.dart';

class LoginWithPhoneApi extends BaseApiRequest {
  LoginRequest loginRequest;
  LoginWithPhoneApi({required this.loginRequest})
      : super(
      serviceType: SERVICE_TYPE.AUTHEN,
      apiName: ApiName.getInstance().login,
      isCheckToken: false,
      isShowErrorPopup: false,
    isShowToastError: false
  );
  Future<dynamic> call() async {
    await getAuthorization();
    dynamic data = await postRequestAPI();
   if(data!=null && data.runtimeType ==ResponseCommon)
     {
       if(data.data!=null)
         {
           AuthInfo loginResponse = AuthInfo.fromJson(data.data);
           await AuthorManager().handleLogout();
           await AuthorManager().saveAuthInfo(loginResponse);
           IdentifierConst.username = loginRequest.username??"";
           GetUserProfileInfoApi getUserProfileInfoApi = GetUserProfileInfoApi();
           try{
             await getUserProfileInfoApi.call();
             await InstanceManager().getFilterCourse();
           }
           catch(e)
           {
             await AuthorManager().handleLogout();
             return false;
           }
           return true;
         }
       else
         {
           ToastUtils.showToastError(data.message??"");
           return false;
         }

     }
   else
     {
       ToastUtils.showToastError(L10nX.getStr.email_or_pass_invalid);
       return false;
     }
  }
  Future<void> getAuthorization() async {
    DeviceInfoModel? deviceInfoModel = await DeviceManager().getDeviceInfo();
    if(deviceInfoModel!=null)
      {
        loginRequest.serialNumber = deviceInfoModel.serialNumber;
        loginRequest.type = deviceInfoModel.type;
        loginRequest.platform = deviceInfoModel.platform;
        print("object");
        await setApiBody(loginRequest.toJson());
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
