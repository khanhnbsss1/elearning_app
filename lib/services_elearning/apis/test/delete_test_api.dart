
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';

import 'models/test_info.dart';


class DeleteTestApi extends BaseApiRequest {
  TestInfo info;
  DeleteTestApi({required this.info}):super(
    serviceType: SERVICE_TYPE.TEST,
    apiName: ApiName.getInstance().deleteTest,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await deleteRequestAPI();
    return result;
  }

  Future<void> getAuthorization() async {
    await setParamsAdd({"testId":info.id});
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
