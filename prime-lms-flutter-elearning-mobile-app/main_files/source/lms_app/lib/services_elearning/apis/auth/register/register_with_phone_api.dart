import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/device_elearning/device_manager.dart';
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
import '../../../../base/widgets/toast_common/toast_utils.dart';
import 'models/register_request.dart';

class RegisterWithPhoneApi extends BaseApiRequest {
  RegisterRequest registerRequest;
  RegisterWithPhoneApi({required this.registerRequest})
      : super(
      serviceType: SERVICE_TYPE.AUTHEN,
      apiName: ApiName.getInstance().registerUserByPhone,
      isCheckToken: false,
      isShowErrorPopup: false,
    isShowToastError: false
  );
  Future<dynamic> call() async {
    await getAuthorization();
    dynamic data = await postRequestAPI();
    if(data.runtimeType == String && (data as String).isEmpty){
      ToastUtils.showToastSuccess(L10nX.getStr.sucessfully_str);
      return true;
    }
    else if(data!=null && data.runtimeType ==ResponseCommon )
     {
           ToastUtils.showToastError(data.message??"");
           return false;
     }
   else
     {
       ToastUtils.showToastError(L10nX.getStr.authen_invalid);
       return false;
     }
  }
  Future<void> getAuthorization() async {
    DeviceInfoModel? deviceInfoModel = await DeviceManager().getDeviceInfo();
    if(deviceInfoModel!=null)
      {
        registerRequest.serialNumber = deviceInfoModel.serialNumber;
        registerRequest.type = deviceInfoModel.type;
        registerRequest.platform = deviceInfoModel.platform;
        await setApiBody(registerRequest.toJson());
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
