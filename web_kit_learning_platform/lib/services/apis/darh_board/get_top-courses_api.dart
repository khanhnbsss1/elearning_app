
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';

import 'models/subscription_purchases_info.dart';
import 'models/synthesisInfo.dart';
import 'models/synthesis_students_info.dart';
import 'models/top_courses_info.dart';

class GetTopCourseApi extends BaseApiRequest {
  int? limit;
  GetTopCourseApi({this.limit}):super(
    serviceType: SERVICE_TYPE.DashBoard,
    apiName: ApiName.getInstance().getTopCourses,
  ){
    limit??=10;
  }

  Future<TopCoursesInfoResponseModel> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return TopCoursesInfoResponseModel();
    }
    else
    {
      TopCoursesInfoResponseModel responseModel = TopCoursesInfoResponseModel.fromJsonList(result);
      return responseModel;
    }
  }

  Future<void> getAuthorization() async {
    await setParamsAdd({
      "limit":limit,
      "type":"DESC"
    });
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
