
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/category/models/category_info.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';

import 'models/create_role_request_info.dart';
import 'models/roles_info.dart';


class UpdateUserRoleApi extends BaseApiRequest {
  String userId;
  String roleId;
  UpdateUserRoleApi({required this.userId, required this.roleId}):super(
    serviceType: SERVICE_TYPE.AUTHEN,
    apiName: ApiName.getInstance().editUserRoles,
    isShowToastError: false,
    isShowErrorPopup: false
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await putRequestAPI();
    if(result.runtimeType == String && (result as String).isEmpty)
    {
      ToastUtils.showToastSuccess(L10nX.getStr.success);
    }
    return result;
  }

  Future<void> getAuthorization() async {
    await setApiBody({
      "userId":userId,
      "roleId":roleId
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
