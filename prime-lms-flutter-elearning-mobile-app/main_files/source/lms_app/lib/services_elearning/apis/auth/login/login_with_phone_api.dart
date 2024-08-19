import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/device_elearning/device_manager.dart';
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
// import 'package:lms_app/base/widgets/biomectric/IdentifierConst.dart';
import 'package:lms_app/services_elearning/apis/user/get_user_detail_api.dart';
import '../../../../base/author/author_manager.dart';
import '../../../../base/instance_mananger_elearning/instance_mananger.dart';
import '../../../../base/widgets/toast_common/toast_utils.dart';
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
             //     final UserCredential? user = await AuthService().loginWithEmailPassword(context, emailCtlr.text.trim(), passwordCtrl.text);
             //     if (user != null) {
             //       _btnController.success();
             //       afterSignIn();
             //     } else {
             //       _btnController.reset();
             //     }
             //   }
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
       ToastUtils.showToastError(L10nX.getStr.email);
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
