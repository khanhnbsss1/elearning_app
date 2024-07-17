import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';

import 'models/course_filtter_info.dart';

class GetCourseFilterApi extends BaseApiRequest {
  GetCourseFilterApi():super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().getFilterCourse,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return CourseFilterListInfo(data: []);
    }
    else
    {
      InstanceManager().courseFilterListInfo = CourseFilterListInfo.fromJson(result);
      return InstanceManager().courseFilterListInfo;
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
