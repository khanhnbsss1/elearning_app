
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
import 'package:lms_app/services_elearning/apis/tags/models/tag_info.dart';

import '../../../base/widgets/toast_common/toast_utils.dart';


class UpdateTagApi extends BaseApiRequest {
  TagsInfo tagInfo;
  UpdateTagApi({required this.tagInfo}):super(
    serviceType: SERVICE_TYPE.TAGS,
    apiName: ApiName.getInstance().updateTag,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await putRequestAPI();
    if(result.runtimeType == String && (result as String).isEmpty)
    {
      ToastUtils.showToastSuccess(L10nX.getStr.sucessfully_str);
    }
    return result;
  }

  Future<void> getAuthorization() async {
    await setApiBody(tagInfo.toJson());
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
