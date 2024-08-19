
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
import '../models/lesson_info.dart';


class GetLessonDetailApi extends BaseApiRequest {
  int lessonId;
  GetLessonDetailApi({required this.lessonId}):super(
    serviceType: SERVICE_TYPE.LESSON,
    apiName: ApiName.getInstance().getDetailLesson,
  );

  Future<LessonInfo?> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();
    if(result.runtimeType!=ResponseCommon)
      {
        LessonInfo lessonInfo = LessonInfo.fromJson(result);
        return lessonInfo;
      }
    else
      {
        return null;
      }
  }

  Future<void> getAuthorization() async {
    await setParamsAdd({"lectureId":lessonId});
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
