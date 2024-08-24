
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';

import 'models/permission_info.dart';

class GetPermissionListApi extends BaseApiRequest {
  GetPermissionListApi():super(
    serviceType: SERVICE_TYPE.Claim,
    apiName: ApiName.getInstance().getUserPermissionList,
  );

  Future<PermissionListResponseModel> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return PermissionListResponseModel(content: [], total: 0, pageSize: 10, pageNumber: 0);
    }
    else
    {
      PermissionListResponseModel responseModel = PermissionListResponseModel.fromList(result);
      return responseModel;
    }
  }

  Future<void> getAuthorization() async {
    UserProfile? userProfile = UserManager().getUserProfile();
     await setApiBody({"roleId":userProfile?.roleId??""});
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
