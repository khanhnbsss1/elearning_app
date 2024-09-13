import 'package:easy_localization/easy_localization.dart';

import '../../../../base/author/user_helper.dart';
import '../../../../base/base_request_elearning/BaseApiRequest.dart';
import '../../../../base/widgets/toast_common/toast_utils.dart';
import '../../../../models/user/UserProfile.dart';

class UpdateLessonStatusApi extends BaseApiRequest {
  int courseId;
  int lectureId;
  int? progress;

  UpdateLessonStatusApi({required this.courseId, required this.lectureId, this.progress}):super(
    serviceType: SERVICE_TYPE.USER,
    apiName: ApiName.getInstance().updateLessonStatus,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();
    if(result.runtimeType == int)
    {
      ToastUtils.showToastSuccess("success".tr());
    }
    return result;
  }

  Future<void> getAuthorization() async {
    UserProfile? userProfile = UserManager().getUserProfile();
    progress??= 0;
    await setApiBody({
      "studentId" : userProfile?.id,
      "courseId" : courseId,
      "lectureId": lectureId,
      "progress": progress
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
