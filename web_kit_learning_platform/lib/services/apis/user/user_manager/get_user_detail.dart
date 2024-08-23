
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';


class GetLessonDetailApi extends BaseApiRequest {
  int userId;
  GetLessonDetailApi({required this.userId}):super(
    serviceType: SERVICE_TYPE.USER,
    apiName: ApiName.getInstance().getUserDetail,
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
    await setParamsAdd({"lectureId":userId});
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
