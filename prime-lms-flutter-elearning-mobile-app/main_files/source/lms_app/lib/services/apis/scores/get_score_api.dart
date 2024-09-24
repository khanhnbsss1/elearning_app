import 'package:lms_app/base/base_request_elearning/models/search_common_request.dart';
import 'package:lms_app/services/apis/course_progress/models/course_proccess_info.dart';
import 'package:lms_app/services/apis/scores/models/test_score_list.dart';
import '../../../base/base_request_elearning/BaseApiRequest.dart';

class GetScoreApi extends BaseApiRequest {
  GetScoreApi():super(
    serviceType: SERVICE_TYPE.Scores,
    apiName: ApiName.getInstance().getScore,
  );

  Future<List<TestScore>> call() async {
    dynamic result = await postRequestAPI();
    if(result.runtimeType == ResponseCommon)
    {
      return [];
    }
    else
    {
      TestScoreListModel testScoreListModel = TestScoreListModel.fromJson(result);
      return testScoreListModel.content??[];
    }
  }

  Future<void> getAuthorization() async {
    setApiBody(SearchCommonRequest(
        pageSize: 100,
        pageNumber: 0
    ));
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

