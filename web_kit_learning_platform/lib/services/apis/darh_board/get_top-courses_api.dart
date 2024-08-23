
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';

import 'models/subscription_purchases_info.dart';
import 'models/synthesisInfo.dart';
import 'models/synthesis_students_info.dart';
import 'models/top_courses_info.dart';

class GetSubscriptionPurchasesApi extends BaseApiRequest {
  GetSubscriptionPurchasesApi():super(
    serviceType: SERVICE_TYPE.DashBoard,
    apiName: ApiName.getInstance().getSubscriptionPurchases,
  );

  Future<TopCoursesInfo> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return TopCoursesInfo();
    }
    else
    {
      TopCoursesInfo responseModel = TopCoursesInfo.fromJson(result);
      return responseModel;
    }
  }

  Future<void> getAuthorization() async {
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
