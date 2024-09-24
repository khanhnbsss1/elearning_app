
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
// import 'package:lms_app/base/services/base_request/models/search_common_request.dart';
import '../../../../base/author/user_helper.dart';
import '../../../../base/base_request_elearning/models/search_common_request.dart';
import '../../../../models/user/UserProfile.dart';
import '../course_detail/models/course_detail_model.dart';
import '../course_list/models/course_models.dart';

class GetFeaturedCourseListApi extends BaseApiRequest {
  GetFeaturedCourseListApi():super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().getFeaturedCourse,
  );

  Future<List<CourseInfo>> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon || result == null) {
      return [];
    }
    try {
      ListCourseInfoModel listCourseInfoModel = ListCourseInfoModel.fromJson(result);
      return listCourseInfoModel.data??[];
    } catch (e) {
      return [];
    }
  }


  Future<void> getAuthorization() async {
    await setParamsAdd({'limit': 10});
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
