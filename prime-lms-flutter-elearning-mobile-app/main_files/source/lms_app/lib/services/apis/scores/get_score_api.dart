import 'package:lms_app/services/apis/scores/models/test_score_list.dart';
import '../../../base/base_request_elearning/BaseApiRequest.dart';

class GetScoreApi extends BaseApiRequest {
  GetScoreApi():super(
    serviceType: SERVICE_TYPE.Scores,
    apiName: ApiName.getInstance().getScore,
  );

  Future<TestScoreList> call() async {
    dynamic result = await getRequestAPI();
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
  }

  @override
  Future<void> onRequestError(int? statusCode, String? statusMessage) async{
    // TODO: implement onRequestError
    super.onRequestError(statusCode, statusMessage);
  }

}

