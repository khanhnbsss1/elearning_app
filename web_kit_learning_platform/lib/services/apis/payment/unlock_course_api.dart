
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';


class UnlockCourseApi extends BaseApiRequest {
  int courseId;
  int? payment;

  UnlockCourseApi({required this.courseId, this.payment}):super(
    serviceType: SERVICE_TYPE.Payments,
    apiName: ApiName.getInstance().unlockCourse,
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
    UserProfile? userProfile = UserManager().getUserProfile();
    payment??= 0;
    await setApiBody({
      "courseId" : courseId,
      "userId": userProfile?.id,
      "payment": payment
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
