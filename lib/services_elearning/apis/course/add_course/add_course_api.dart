
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';

import '../course_detail/models/course_detail_model.dart';

class AddCourseApi extends BaseApiRequest {
  CourseInfo addCourseRequest;
  AddCourseApi({required this.addCourseRequest}):super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().createCourse,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();
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
