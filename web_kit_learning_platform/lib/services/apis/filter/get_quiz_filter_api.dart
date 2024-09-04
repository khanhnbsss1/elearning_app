
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';


class GetQuizFilterApi extends BaseApiRequest {
  GetQuizFilterApi():super(
    serviceType: SERVICE_TYPE.QUIZ,
    apiName: ApiName.getInstance().getQuizFilter,
  );

  Future<QuestionListResponseModel> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return QuestionListResponseModel(content: [], total: 0, pageSize: 10, pageNumber: 0);
    }
    else
    {
      FilterResponseModel model = FilterResponseModel.fromJsonList(result);
      QuestionListResponseModel questionListResponseModel = QuestionListResponseModel.fromFilter(model);
      return questionListResponseModel;
    }
  }

  Future<void> getAuthorization() async {
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

