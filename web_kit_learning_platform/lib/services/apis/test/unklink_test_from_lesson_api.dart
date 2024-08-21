import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';

class UnLinkTestToLessonApi extends BaseApiRequest {
  int testId;
  int lessonId;
  UnLinkTestToLessonApi({required this.testId, required this.lessonId}):super(
    serviceType: SERVICE_TYPE.LESSON,
    apiName: ApiName.getInstance().unLinkTestFromLesson,
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
      return result;
    }
  }

  Future<void> getAuthorization() async {
    await setApiBody({
      "lectureId":lessonId,
      "testId":testId,
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
