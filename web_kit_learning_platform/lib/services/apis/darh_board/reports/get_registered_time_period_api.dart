
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';

import 'models/registered_time_period_info.dart';

class GetRegisterTimePeriodApi extends BaseApiRequest {
  SearchCommonRequest dashboardSearchModel;
  GetRegisterTimePeriodApi({required this.dashboardSearchModel}):super(
    serviceType: SERVICE_TYPE.DashBoard,
    apiName: ApiName.getInstance().getRegisterTimePeriod,
  );

  Future<RegisterTimePeriodResponseModel> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return RegisterTimePeriodResponseModel();
    }
    else
    {
      RegisterTimePeriodResponseModel responseModel = RegisterTimePeriodResponseModel.fromJson(result);
      return responseModel;
    }
  }

  Future<void> getAuthorization() async {
    await setApiBody(dashboardSearchModel.toJson());
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
