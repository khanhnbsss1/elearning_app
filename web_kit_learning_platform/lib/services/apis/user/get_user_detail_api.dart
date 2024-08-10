import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';

class GetUserProfileInfoApi extends BaseApiRequest {
  GetUserProfileInfoApi():super(
    serviceType: SERVICE_TYPE.USER,
    apiName: ApiName.getInstance().getUserDetail,
  );

  Future<dynamic> call() async {
    dynamic result = await getRequestAPI();
    if(result.runtimeType == ResponseCommon)
    {
      return null;
    }
    else
    {
      UserProfile userProfile = UserProfile.fromJson(result);
      UserManager().saveUserProfileInfo(userProfile);
      return userProfile;
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
