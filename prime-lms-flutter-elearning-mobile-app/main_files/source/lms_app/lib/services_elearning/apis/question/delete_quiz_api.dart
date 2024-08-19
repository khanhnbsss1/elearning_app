
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
import 'models/question_info.dart';

class DeleteQuizApi extends BaseApiRequest {
  QuestionInfo info;
  DeleteQuizApi({required this.info}):super(
    serviceType: SERVICE_TYPE.QUIZ,
    apiName: ApiName.getInstance().deleteQuiz,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await deleteRequestAPI();
    return result;
  }

  Future<void> getAuthorization() async {
    await setParamsAdd({"quizId":info.id});
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

