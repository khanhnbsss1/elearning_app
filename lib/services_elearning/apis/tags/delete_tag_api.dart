
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
import 'package:lms_app/services_elearning/apis/tags/models/tag_info.dart';


class DeleteTagApi extends BaseApiRequest {
  TagsInfo tagInfo;
  DeleteTagApi({required this.tagInfo}):super(
    serviceType: SERVICE_TYPE.TAGS,
    apiName: ApiName.getInstance().deleteTag,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await deleteRequestAPI();
    return result;
  }

  Future<void> getAuthorization() async {
    await setParamsAdd({"tagId":tagInfo.id});
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
