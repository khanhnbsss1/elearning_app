import 'package:webkit/base/device/device_manager.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/EnumCommon.dart';
import 'package:webkit/base/services/base_request/apiName.dart';
import 'package:webkit/base/services/base_request/models/response_error_objects.dart';
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
   if(data!=null && data.runtimeType ==ResponseCommon && data.data !=null)
     {
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
