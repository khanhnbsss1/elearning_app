
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';

import 'models/category_info.dart';

class GetCategoryListApi extends BaseApiRequest {
  GetCategoryListApi():super(
    serviceType: SERVICE_TYPE.CATEGORY,
    apiName: ApiName.getInstance().getCategories,
  );

  Future<CategoryListResponseModel> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return CategoryListResponseModel(content: [], total: 0, pageSize: 10, pageNumber: 0);
    }
    else
    {
      CategoryListResponseModel model = CategoryListResponseModel.fromList(result);
      return model;
    }
  }

  Future<void> getAuthorization() async {
    //await setApiBody(searchCommonRequest.toJson());
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
