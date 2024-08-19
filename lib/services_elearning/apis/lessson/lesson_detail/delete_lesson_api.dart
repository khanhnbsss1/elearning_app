
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';

import '../models/lesson_info.dart';


class DeleteLessonApi extends BaseApiRequest {
  LessonInfo lessonInfo;
  DeleteLessonApi({required this.lessonInfo}):super(
    serviceType: SERVICE_TYPE.TAGS,
    apiName: ApiName.getInstance().deleteLesson,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();
    return result;
  }

  Future<void> getAuthorization() async {
    await setApiBody(lessonInfo.toJson());
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
