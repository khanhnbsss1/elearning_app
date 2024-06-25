import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/EnumCommon.dart';
import 'package:webkit/base/services/base_request/apiName.dart';
import 'package:webkit/base/services/base_request/models/response_error_objects.dart';
import 'package:webkit/services/apis/course/models/course_list_response_model.dart';
import 'package:webkit/services/apis/user/models/landing_page_teacher_model.dart';

enum UserTypeName{
  teacher,
  user
}
Map<UserTypeName, String>typeNameToStr={
  UserTypeName.teacher:"Teacher",
  UserTypeName.user:"User",

};
class LandingPageUserListApi extends BaseApiRequest {
  UserTypeName typeName;
  LandingPageUserListApi({required this.typeName}):super(
    serviceType: SERVICE_TYPE.LandingPages,
    apiName: ApiName.getInstance().getTeacherListLandingPage,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();
    if(result.runtimeType == ResponseCommon)
    {
      return CourseListLandingPageResponseModel(data: []);
    }
    else
    {
      LandingPageUserListModel paymentHistoryResponseModel = LandingPageUserListModel.fromJsonList(result);
      return paymentHistoryResponseModel;
    }

  }

  Future<void> getAuthorization() async {
    await setParamsAdd({"type": typeNameToStr[typeName]});
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
