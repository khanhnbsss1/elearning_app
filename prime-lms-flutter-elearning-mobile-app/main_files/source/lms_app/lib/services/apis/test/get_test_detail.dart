
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
import 'package:lms_app/services/apis/lessson/models/lesson_info.dart';
import 'package:lms_app/services/apis/test/models/test_info.dart';

import 'models/test_detail.dart';


class GetTestDetailApi extends BaseApiRequest {
  int testId;
  GetTestDetailApi({required this.testId}):super(
    serviceType: SERVICE_TYPE.TEST,
    apiName: ApiName.getInstance().detailTest,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();
    if(result.runtimeType!=ResponseCommon)
      {
        TestDetail testDetail = TestDetail.fromJson(result);
        return testDetail;
      }
    else
      {
        return TestDetail();
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
