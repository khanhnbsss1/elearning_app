import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';

import '../../../../base/widgets/toast_common/toast_utils.dart';

class UnLinkLessonApi extends BaseApiRequest {
  int courseId;
  int lessonId;
  String subject;
  UnLinkLessonApi({required this.courseId, required this.lessonId, required this.subject}):super(
    serviceType: SERVICE_TYPE.LESSON,
    apiName: ApiName.getInstance().unlinkLesson,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      ToastUtils.showToastError((result as ResponseCommon).message??"");
      return null;
    }
    else
    {     
      ToastUtils.showToastSuccess(L10nX.getStr.sucessfully_str);
      return result;
    }
  }

  Future<void> getAuthorization() async {
    await setApiBody({
      "id":lessonId,
      "courseId":courseId,
      "subName":subject,

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
