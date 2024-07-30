import 'dart:convert';

import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/EnumCommon.dart';
import 'package:webkit/base/services/base_request/apiName.dart';

import '../../../../base/services/base_request/models/response_error_objects.dart';
import '../course_list/models/course_models.dart';
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
