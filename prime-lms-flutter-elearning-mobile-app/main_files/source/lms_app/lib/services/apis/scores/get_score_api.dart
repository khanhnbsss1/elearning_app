import 'package:lms_app/base/base_request_elearning/models/search_common_request.dart';
import 'package:lms_app/services/apis/scores/models/test_score_list.dart';
import '../../../base/base_request_elearning/BaseApiRequest.dart';

class GetScoreApi extends BaseApiRequest {
  GetScoreApi():super(
    serviceType: SERVICE_TYPE.Scores,
    apiName: ApiName.getInstance().getScore,
  );

  Future<TestScoreList> call() async {
    dynamic result = await postRequestAPI();
    if(result.runtimeType == ResponseCommon)
    {
      return TestScoreList();
    }
    else
    {
      TestScoreList testScoreList = TestScoreList.fromJson(result);
      return testScoreList;
    }
  }

  Future<void> getAuthorization() async {
  }

  @override
  Future<void> onRequestSuccess(var data) async {
    // TODO: implement onRequestSuccess
    super.onRequestSuccess(data);
    setApiBody(SearchCommonRequest(
      pageSize: 100,
      pageNumber: 0
    ));
  }

  @override
  Future<void> onRequestError(int? statusCode, String? statusMessage) async{
    // TODO: implement onRequestError
    super.onRequestError(statusCode, statusMessage);
  }

}

