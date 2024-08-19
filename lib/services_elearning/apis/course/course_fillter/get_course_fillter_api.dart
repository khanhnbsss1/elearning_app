import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';

import '../../../../base/instance_mananger_elearning/instance_mananger.dart';
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
      return CourseFilterListInfo(data: [CourseFilterInfo(filterType: "ALL", id: -1,name: "All",selectSubFilter: null, subFilter: [])]);
    }
    else
    {
      (InstanceManager().courseFilterListInfo.data??[]).clear();
      (InstanceManager().courseFilterListInfo.data??[]).add(CourseFilterInfo(filterType: "ALL", id: -1,name: "All",selectSubFilter: null, subFilter: []));
      (InstanceManager().courseFilterListInfo.data??[]).addAll(CourseFilterListInfo.fromJson(result).data??[]);
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
