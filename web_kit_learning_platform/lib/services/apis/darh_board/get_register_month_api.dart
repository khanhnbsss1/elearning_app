
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';

import 'models/register_month_info.dart';

class GetRegisterMonthApi extends BaseApiRequest {
  SearchCommonRequest dashboardSearchModel;
  GetRegisterMonthApi({required this.dashboardSearchModel}):super(
    serviceType: SERVICE_TYPE.DashBoard,
    apiName: ApiName.getInstance().getRegisterMonth,
  );

  Future<RegisterMonthResponseModel> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return RegisterMonthResponseModel();
    }
    else
    {
      RegisterMonthResponseModel responseModel = RegisterMonthResponseModel.fromJsonList(result);
      return responseModel;
    }
  }

  Future<void> getAuthorization() async {
    await setParamsAdd(dashboardSearchModel.toJson());
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
