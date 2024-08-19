
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';


class UpdateLessonStatusApi extends BaseApiRequest {
  int courseId;
  int lectureId;
  String? status;
  UpdateLessonStatusApi({required this.courseId, required this.lectureId, this.status}):super(
    serviceType: SERVICE_TYPE.USER,
    apiName: ApiName.getInstance().updateLessonStatus,
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
    status??='Completed';
    await setApiBody({
      "studentId" : userProfile?.id,
      "courseId" : courseId,
      "lectureId": lectureId,
      "status": status
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
