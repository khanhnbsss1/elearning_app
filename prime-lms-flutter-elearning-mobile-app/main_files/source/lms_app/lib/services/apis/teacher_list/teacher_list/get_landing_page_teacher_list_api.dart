

import '../../../../base/base_request_elearning/BaseApiRequest.dart';
import '../models/landing_page_teacher_list_model.dart';

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
      return LandingPageUserListModel(data: []);
    }
    else
    {
      LandingPageUserListModel landingPageUserListModel = LandingPageUserListModel.fromJsonList(result);
      return landingPageUserListModel.data;
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
