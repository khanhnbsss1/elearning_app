
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';

import 'models/course_detail_model.dart';

enum CourseDetailAction{ 
  view,
  edit,
  add, 
  delete
}
class CourseDetailApi extends BaseApiRequest {
  int courseId;
  CourseDetailApi({required this.courseId}):super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().getCourseDetail,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return null;
    }
    else
    {
      CourseInfo courseInfo = CourseInfo.fromJson(result);
      return courseInfo;
    }
  }

  Future<void> getAuthorization() async {
     await setApiBody({"courseId": courseId});
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
