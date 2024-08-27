
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';

import '../course_detail/models/course_detail_model.dart';

class UpdateCourseApi extends BaseApiRequest {
  CourseInfo addCourseRequest;
  UpdateCourseApi({required this.addCourseRequest}):super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().updateCourse,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await putRequestAPI();
    return result;
  }

  Future<void> getAuthorization() async {
    await setApiBody(addCourseRequest.toJson());
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
