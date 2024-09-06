
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';

import 'models/course_history_info.dart';

class GetCourseHistoryApi extends BaseApiRequest {
  SearchCommonRequest dashboardSearchModel;
  GetCourseHistoryApi({required this.dashboardSearchModel}):super(
    serviceType: SERVICE_TYPE.DashBoard,
    apiName: ApiName.getInstance().getCourseHistory,
  );

  Future<CourseHistoryListResponseModel> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return CourseHistoryListResponseModel();
    }
    else
    {
      CourseHistoryListResponseModel responseModel = CourseHistoryListResponseModel.fromJson(result);
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
