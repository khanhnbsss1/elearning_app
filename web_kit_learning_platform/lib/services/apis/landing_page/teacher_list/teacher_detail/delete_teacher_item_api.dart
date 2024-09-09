
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';

import '../models/landing_page_teacher_list_model.dart';


class DeleteTeacherApi extends BaseApiRequest {
  LandingPageUserInfo info;
  DeleteTeacherApi({required this.info}):super(
    serviceType: SERVICE_TYPE.LandingPages,
    apiName: ApiName.getInstance().deleteLandingPageTeacher,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await deleteRequestAPI();
    return result;
  }

  Future<void> getAuthorization() async {
    await setParamsAdd({
      "teacherId": info.id
    });
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
