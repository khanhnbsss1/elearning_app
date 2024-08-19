
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';


class DeleteLessonApi extends BaseApiRequest {
  LessonInfo lessonInfo;
  DeleteLessonApi({required this.lessonInfo}):super(
    serviceType: SERVICE_TYPE.LESSON,
    apiName: ApiName.getInstance().deleteLesson,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();
    return result;
  }

  Future<void> getAuthorization() async {
    await setParamsAdd({
      "lectureId": lessonInfo.id
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
