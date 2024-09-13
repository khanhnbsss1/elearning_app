
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';

import '../../../../base/author/user_helper.dart';
import '../../../../base/base_request_elearning/models/search_common_request.dart';
import '../../../../models/user/UserProfile.dart';
import '../course_list/models/course_models.dart';

class RegisterCourseApi extends BaseApiRequest {
  int courseId;
  RegisterCourseApi({required this.courseId}):super(
    serviceType: SERVICE_TYPE.USER,
    apiName: ApiName.getInstance().registerCourse,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();
    if(result.runtimeType == ResponseCommon || result == null)
    {
      return false;
    }
    else
    {
      return true;
    }
  }

  Future<void> getAuthorization() async {
    Map<String, dynamic> request = {"course_id": courseId.toString()};
    await setApiBody(request);
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
