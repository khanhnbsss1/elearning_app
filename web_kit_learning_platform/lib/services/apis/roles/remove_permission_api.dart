
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/category/models/category_info.dart';
import 'package:webkit/services/apis/permission/models/permission_info.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';

import 'models/create_role_request_info.dart';
import 'models/roles_info.dart';


class RemovePermissionApi extends BaseApiRequest {
  List<PermissionInfo> info;
  String roleId;
  RemovePermissionApi({required this.info, required this.roleId}):super(
    serviceType: SERVICE_TYPE.Claim,
    apiName: ApiName.getInstance().deletePermissionListFromRole,
    isShowToastError: false
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();
    if(result.runtimeType == String && (result as String).isEmpty)
    {
      ToastUtils.showToastSuccess(L10nX.getStr.success);
    }
    return result;
  }

  Future<void> getAuthorization() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claims'] = info.map((v) => v.toJson()).toList();
    data['roleId'] = roleId;
    await setApiBody(data);
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
