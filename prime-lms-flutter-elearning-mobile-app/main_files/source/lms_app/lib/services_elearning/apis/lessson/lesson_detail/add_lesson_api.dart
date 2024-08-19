
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';

import '../../../../base/widgets/toast_common/toast_utils.dart';
import '../models/lesson_info.dart';


class AddLessonApi extends BaseApiRequest {
  LessonInfo lessonInfo;
  AddLessonApi({required this.lessonInfo}):super(
    serviceType: SERVICE_TYPE.LESSON,
    apiName: ApiName.getInstance().createLesson,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();
    if(result.runtimeType == int)
    {
      ToastUtils.showToastSuccess(L10nX.getStr.sucessfully_str);
    }
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
