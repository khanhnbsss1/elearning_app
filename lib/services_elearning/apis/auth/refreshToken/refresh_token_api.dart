import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/device_elearning/device_manager.dart';
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
import 'package:lms_app/services_elearning/apis/auth/login/models/login_response.dart';

import '../../../../base/author/author_manager.dart';
import '../../../../base/widgets/toast_common/toast_utils.dart';
import 'models/refresh_token_request.dart';
class RefreshTokenApi extends BaseApiRequest {
  AuthInfo ?authInfo;
  RefreshTokenApi({required this.authInfo})
      : super(
      serviceType: SERVICE_TYPE.AUTHEN,
      apiName: ApiName.getInstance().refreshToken,
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
           AuthInfo authInfo = AuthInfo.fromJson(data.data);
           await AuthorManager().saveAuthInfo(authInfo);
         }
       else
         {
           /// neu refresh token het han thi out ra ngoai landing page
           ToastUtils.showToastError(data.message??"");
           AuthorManager().handleLogout();
           // AppPages.routeName(Routes.landingPageRoute, isReplace: true);
         }

     }
   else
     {
       /// neu refresh token het han thi out ra ngoai landing page
       AuthorManager().handleLogout();
       // AppPages.routeName(Routes.landingPageRoute, isReplace: true);
     }
  }
  Future<void> getAuthorization() async {
    DeviceInfoModel? deviceInfoModel = await DeviceManager().getDeviceInfo();
    if(deviceInfoModel!=null && authInfo!=null)
      {
        RefreshTokenRequest refreshTokenRequest = RefreshTokenRequest(
          deviceType:  deviceInfoModel.type,
          accessToken: authInfo?.accessToken,
          refreshToken: authInfo?.refreshToken
        );
        print("object");
        await setApiBody(refreshTokenRequest.toJson());
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
