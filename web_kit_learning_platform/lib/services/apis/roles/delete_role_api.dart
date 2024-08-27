
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';


import 'models/roles_info.dart';


class DeleteRoleApi extends BaseApiRequest {
  RoleInfo info;
  DeleteRoleApi({required this.info}):super(
    serviceType: SERVICE_TYPE.AUTHEN,
    apiName: ApiName.getInstance().deleteRoles,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await deleteRequestAPI();
    return result;
  }

  Future<void> getAuthorization() async {
    await setParamsAdd({"roleId":info.id, "field":info.id});
    await setApiBody({"roleId":info.id, "field":info.id});

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
