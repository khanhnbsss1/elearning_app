
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';

import 'models/roles_info.dart';

class GetRoleListApi extends BaseApiRequest {
  GetRoleListApi():super(
    serviceType: SERVICE_TYPE.AUTHEN,
    apiName: ApiName.getInstance().getUserRolesList,
  );

  Future<RolesListResponseModel> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return RolesListResponseModel(content: [], total: 0, pageSize: 10, pageNumber: 0);
    }
    else
    {
      RolesListResponseModel model = RolesListResponseModel.fromList(result);
      return model;
    }
  }

  Future<void> getAuthorization() async {
    //await setApiBody(searchCommonRequest.toJson());
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
