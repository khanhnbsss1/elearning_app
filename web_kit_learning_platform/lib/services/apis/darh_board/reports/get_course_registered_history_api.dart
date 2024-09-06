
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';

import '../../../../base/services/base_request/models/search_common_request.dart';
import 'models/course_registed_history_info.dart';
import 'models/revenue_history_info.dart';

class GetCourseRegisteredHistoryApi extends BaseApiRequest {
  SearchCommonRequest dashboardSearchModel;
  GetCourseRegisteredHistoryApi({required this.dashboardSearchModel}):super(
    serviceType: SERVICE_TYPE.DashBoard,
    apiName: ApiName.getInstance().getCourseRegistrationHistory,
  );

  Future<CourseRegisteredHistoryListResponseModel> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return CourseRegisteredHistoryListResponseModel();
    }
    else
    {
      CourseRegisteredHistoryListResponseModel responseModel = CourseRegisteredHistoryListResponseModel.fromJson(result);
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
