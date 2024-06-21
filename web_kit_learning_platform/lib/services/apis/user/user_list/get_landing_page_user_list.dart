import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/EnumCommon.dart';
import 'package:webkit/base/services/base_request/apiName.dart';
import 'package:webkit/base/services/base_request/models/response_error_objects.dart';
import 'package:webkit/services/apis/course/models/course_list_response_model.dart';

enum TypeName{
  teacher,
  user
}
Map<TypeName, String>typeNameToStr={
  TypeName.teacher:"Teacher",
  TypeName.user:"User",

};
class LandingPageUserListApi extends BaseApiRequest {
  TypeName typeName;
  LandingPageUserListApi({required this.typeName}):super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().getCourseListLandingPage,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();
    if(result.runtimeType == ResponseCommon)
    {
      return CourseListLandingPageResponseModel(data: []);
    }
    else
    {
      CourseListLandingPageResponseModel paymentHistoryResponseModel = CourseListLandingPageResponseModel.fromJson(result);
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
