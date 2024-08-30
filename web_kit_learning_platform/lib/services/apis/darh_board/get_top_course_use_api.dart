
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/darh_board/request_model/dash_board_search_model.dart';

import 'models/subscription_purchases_info.dart';
import 'models/synthesisInfo.dart';
import 'models/synthesis_students_info.dart';
import 'models/top_course_revenue_info.dart';
import 'models/top_courses_info.dart';
import 'models/user_registration_info.dart';

class GetTopCourseUserApi extends BaseApiRequest {
  DashboardSearchModel dashboardSearchModel;
  GetTopCourseUserApi({required this.dashboardSearchModel}):super(
    serviceType: SERVICE_TYPE.DashBoard,
    apiName: ApiName.getInstance().getTopCourseUser,
  );

  Future<TopCourseRevenueResponseModel> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return TopCourseRevenueResponseModel();
    }
    else
    {
      TopCourseRevenueResponseModel responseModel = TopCourseRevenueResponseModel.fromJsonList(result);
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
