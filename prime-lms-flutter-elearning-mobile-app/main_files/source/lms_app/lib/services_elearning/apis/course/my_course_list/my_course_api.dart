
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
// import 'package:webkit/base/services/base_request/models/search_common_request.dart';

import '../../../../base/author/user_helper.dart';
import '../../../../base/base_request_elearning/models/search_common_request.dart';
import '../../../../models/user/UserProfile.dart';
import '../course_list/models/course_models.dart';

class MyCourseApi extends BaseApiRequest {
  SearchCommonRequest searchCommonRequest;
  MyCourseApi({required this.searchCommonRequest}):super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().getMyCourses,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return CourseResponseModel(content: []);
    }
    else
    {
      CourseResponseModel courseResponseModel = CourseResponseModel.fromJson(result);
      return courseResponseModel;
    }
  }

  Future<void> getAuthorization() async {
    UserProfile? userProfile = await UserManager().getUserProfile();
    if(userProfile!=null) {
      searchCommonRequest = searchCommonRequest.copyWith(userId: userProfile.id);
    }
    await setApiBody(searchCommonRequest.toJson());  }

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
