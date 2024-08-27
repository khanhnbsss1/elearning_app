
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';

import '../../../base/widgets/toast_common/toast_utils.dart';
import 'models/test_info.dart';


class AddTestApi extends BaseApiRequest {
  TestInfo info;
  AddTestApi({required this.info}):super(
    serviceType: SERVICE_TYPE.TEST,
    apiName: ApiName.getInstance().createTest,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();
    if(result.runtimeType == String && (result as String).isEmpty)
    {
      ToastUtils.showToastSuccess(L10nX.getStr.sucessfully_str);
    }
    return result;
  }

  Future<void> getAuthorization() async {
    await setApiBody(info.toJson());
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
