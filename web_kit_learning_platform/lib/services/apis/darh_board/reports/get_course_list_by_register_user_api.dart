
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/course/course_list/models/course_models.dart';

import '../../../../base/services/base_request/models/search_common_request.dart';
import 'models/course_registed_history_info.dart';
import 'models/revenue_history_info.dart';

class GetCourseListByRegistedUserApi extends BaseApiRequest {
  SearchCommonRequest dashboardSearchModel;
  GetCourseListByRegistedUserApi({required this.dashboardSearchModel}):super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().courseByRegistrationUser,
  );

  Future<CourseResponseModel> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return CourseResponseModel(content: []);
    }
    else
    {
      CourseResponseModel responseModel = CourseResponseModel.fromJson(result);
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
