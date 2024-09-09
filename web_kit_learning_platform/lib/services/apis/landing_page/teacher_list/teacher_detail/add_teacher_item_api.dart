
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';

import '../models/landing_page_teacher_list_model.dart';


class AddTeacherApi extends BaseApiRequest {
  LandingPageUserInfo info;
  AddTeacherApi({required this.info}):super(
    serviceType: SERVICE_TYPE.LandingPages,
    apiName: ApiName.getInstance().createLandingPageTeacher,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();
    if(result.runtimeType == int)
    {
      ToastUtils.showToastSuccess(L10nX.getStr.success);
    }
    return result;
  }

  Future<void> getAuthorization() async {
    await setApiBody(info.toJson());
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
