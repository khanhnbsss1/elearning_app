
import 'package:webkit/base/models/user/UserProfile.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';


class DeleteUserApi extends BaseApiRequest {
  UserProfile info;
  DeleteUserApi({required this.info}):super(
    serviceType: SERVICE_TYPE.AUTHEN,
    apiName: ApiName.getInstance().deleteUser,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await deleteRequestAPI();
    return result;
  }

  Future<void> getAuthorization() async {
    await setApiBody(info.toJson());
    await setParamsAdd({
      "username":info.userName,
      "type":info.typeName
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
