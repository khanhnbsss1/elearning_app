
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/category/models/category_info.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';


class DeleteTagApi extends BaseApiRequest {
  CategoryInfo info;
  DeleteTagApi({required this.info}):super(
    serviceType: SERVICE_TYPE.CATEGORY,
    apiName: ApiName.getInstance().deleteCategory,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await deleteRequestAPI();
    return result;
  }

  Future<void> getAuthorization() async {
    await setParamsAdd({"cateId":info.id});
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
