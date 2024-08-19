import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/landing_page/course/models/course_list_landing_page_response_model.dart';
import 'package:webkit/services/apis/landing_page/teacher_list/models/landing_page_teacher_list_model.dart';

class LandingPageTeacherListApi extends BaseApiRequest {
  LandingPageTeacherListApi():super(
    serviceType: SERVICE_TYPE.LandingPages,
    apiName: ApiName.getInstance().getTeacherListLandingPage,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();
    if(result.runtimeType == ResponseCommon)
    {
      return CourseListResponseModel(data: []);
    }
    else
    {
      LandingPageUserListModel paymentHistoryResponseModel = LandingPageUserListModel.fromJsonList(result);
      return paymentHistoryResponseModel;
    }
    
    
    

  }

  Future<void> getAuthorization() async {
    //await setParamsAdd({"type": typeNameToStr[typeName]});
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
