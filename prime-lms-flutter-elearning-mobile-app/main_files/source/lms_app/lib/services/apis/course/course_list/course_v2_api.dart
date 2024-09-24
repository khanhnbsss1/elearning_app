
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
// import 'package:lms_app/base/services/base_request/models/search_common_request.dart';
import '../../../../base/author/user_helper.dart';
import '../../../../base/base_request_elearning/models/search_common_request.dart';
import '../../../../base/base_request_elearning/models/search_common_request_v2.dart';
import '../../../../models/user/UserProfile.dart';
import '../course_list/models/course_models.dart';

class GetCourseListV2Api extends BaseApiRequest {
  SearchCommonRequestV2 searchCommonRequestV2;
  GetCourseListV2Api({required this.searchCommonRequestV2}):super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().getAdvancedCourseList,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon || result == null) {
      return CourseResponseModel(content: [], total: 0, pageSize: 0, pageNumber: 0);
    }
    try {
      CourseResponseModel paymentHistoryResponseModel = CourseResponseModel.fromJson(result);
      return paymentHistoryResponseModel;
    } catch (e) {
      return CourseResponseModel(content: [], total: 0, pageSize: 0, pageNumber: 0);
    }
  }


  Future<void> getAuthorization() async {
     await setApiBody(searchCommonRequestV2.toJson());
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
