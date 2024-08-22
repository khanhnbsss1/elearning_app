
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';


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
