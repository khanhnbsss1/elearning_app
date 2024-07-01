import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/EnumCommon.dart';
import 'package:webkit/base/services/base_request/apiName.dart';
import 'package:webkit/base/services/base_request/models/response_error_objects.dart';

class GetUserProfileInfoApi extends BaseApiRequest {
  GetUserProfileInfoApi():super(
    serviceType: SERVICE_TYPE.USER,
    apiName: ApiName.getInstance().getUserDetail,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();
    if(result.runtimeType == ResponseCommon)
    {
      return null;
    }
    else
    {
      UserProfile userProfile = UserProfile.fromJson(result['data']);
      UserManager().saveUserProfileInfo(userProfile);
      return userProfile;
    }
    
  }

  Future<void> getAuthorization() async {
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
