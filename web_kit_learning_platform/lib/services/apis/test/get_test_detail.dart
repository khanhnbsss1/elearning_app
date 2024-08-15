
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';


class GetTestDetailApi extends BaseApiRequest {
  int testId;
  GetTestDetailApi({required this.testId}):super(
    serviceType: SERVICE_TYPE.TEST,
    apiName: ApiName.getInstance().detailTest,
  );

  Future<TestInfo?> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();
    if(result.runtimeType!=ResponseCommon)
      {
        TestInfo lessonInfo = TestInfo.fromJson(result);
        return lessonInfo;
      }
    else
      {
        return null;
      }
  }

  Future<void> getAuthorization() async {
    await setParamsAdd({"testId":testId});
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
