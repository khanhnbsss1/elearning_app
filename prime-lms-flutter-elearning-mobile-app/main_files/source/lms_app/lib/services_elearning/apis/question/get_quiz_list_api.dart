
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
// import 'package:webkit/base/services/base_request/models/search_common_request.dart';

import '../../../base/base_request_elearning/models/search_common_request.dart';
import 'models/question_info.dart';


class GetQuizListApi extends BaseApiRequest {
  SearchCommonRequest searchCommonRequest;
  GetQuizListApi({required this.searchCommonRequest}):super(
    serviceType: SERVICE_TYPE.QUIZ,
    apiName: ApiName.getInstance().getQuizList,
  );

  Future<QuestionListResponseModel> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return QuestionListResponseModel(content: [], total: 0, pageSize: 0, pageNumber: 0);
    }
    else
    {
      QuestionListResponseModel model = QuestionListResponseModel.fromList(result);
      return model;
    }
  }

  Future<void> getAuthorization() async {
    await setApiBody(searchCommonRequest.toJson());
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

