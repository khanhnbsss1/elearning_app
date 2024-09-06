
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';


import 'models/subscription_purchases_info.dart';
import 'models/synthesisInfo.dart';
import 'models/synthesis_students_info.dart';

class GetSubscriptionPurchasesApi extends BaseApiRequest {
  SearchCommonRequest dashboardSearchModel;
  GetSubscriptionPurchasesApi({required this.dashboardSearchModel}):super(
    serviceType: SERVICE_TYPE.DashBoard,
    apiName: ApiName.getInstance().getSubscriptionPurchases,
  );

  Future<SubscriptionPurchasesInfoResponseModel> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return SubscriptionPurchasesInfoResponseModel();
    }
    else
    {
      SubscriptionPurchasesInfoResponseModel responseModel = SubscriptionPurchasesInfoResponseModel.fromJsonList(result);
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
