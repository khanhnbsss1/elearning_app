
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/darh_board/request_model/dash_board_search_model.dart';

import '../models/subscription_purchases_info.dart';
import '../models/synthesisInfo.dart';
import '../models/synthesis_students_info.dart';
import '../models/top_course_revenue_info.dart';
import '../models/top_courses_info.dart';
import '../models/user_registration_info.dart';
import 'models/revenue_history_info.dart';

class GetCourseRegisteredHistoryApi extends BaseApiRequest {
  DashboardSearchModel dashboardSearchModel;
  GetCourseRegisteredHistoryApi({required this.dashboardSearchModel}):super(
    serviceType: SERVICE_TYPE.DashBoard,
    apiName: ApiName.getInstance().getCourseRegistrationHistory,
  );

  Future<RevenueHistoryListResponseModel> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return RevenueHistoryListResponseModel();
    }
    else
    {
      RevenueHistoryListResponseModel responseModel = RevenueHistoryListResponseModel.fromJson(result);
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
