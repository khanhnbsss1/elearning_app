import 'package:webkit/base/services/base_request/BaseApiRequest.dart';

import 'models/course_filtter_info.dart';

class GetCourseFilterApi extends BaseApiRequest {
  GetCourseFilterApi():super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().getCourseDetail,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return CourseFilterListInfo(data: []);
    }
    else
    {
      CourseFilterListInfo courseFilterListInfo = CourseFilterListInfo.fromJson(result);
      return courseFilterListInfo;
    }
  }

  Future<void> getAuthorization() async {}

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
