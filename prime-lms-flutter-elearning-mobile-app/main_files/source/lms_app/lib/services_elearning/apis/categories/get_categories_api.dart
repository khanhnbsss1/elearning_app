import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
import 'package:lms_app/services_elearning/apis/tags/models/tag_info.dart';

class GetCategoriesApi extends BaseApiRequest {
  GetCategoriesApi() :super(
    serviceType: SERVICE_TYPE.CATEGORIES,
    apiName: ApiName().getCategories,
  );

  Future<List<TagsInfo>> call() async {
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return [];
    }
    else
    {
      CategoriesModel categoriesModel = CategoriesModel.fromJson(result);
      List<TagsInfo> t = categoriesModel.data??[];
      return categoriesModel.data??[];
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