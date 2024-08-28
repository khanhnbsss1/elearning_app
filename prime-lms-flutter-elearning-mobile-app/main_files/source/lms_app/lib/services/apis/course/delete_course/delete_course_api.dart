

import '../../../../base/base_request_elearning/BaseApiRequest.dart';
import '../course_detail/models/course_detail_model.dart';

class DeleteCourseApi extends BaseApiRequest {
  CourseInfo info;
  DeleteCourseApi({required this.info}):super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().deleteCourse,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await deleteRequestAPI();
    return result;
  }

  Future<void> getAuthorization() async {
    await setParamsAdd({"courseId":info.id});
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
