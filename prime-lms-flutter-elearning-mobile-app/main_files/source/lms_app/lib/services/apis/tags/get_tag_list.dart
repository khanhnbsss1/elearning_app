
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';

import 'models/tag_info.dart';

class GetTagListApi extends BaseApiRequest {
  SearchCommonRequest searchCommonRequest;
  GetTagListApi({required this.searchCommonRequest}):super(
    serviceType: SERVICE_TYPE.TAGS,
    apiName: ApiName.getInstance().getTagsList,
  );

  Future<TagListResponseModel> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return TagListResponseModel(content: [], total: 0, pageSize: 10, pageNumber: 0);
    }
    else
    {
      TagListResponseModel paymentHistoryResponseModel = TagListResponseModel.fromList(result);
      return paymentHistoryResponseModel;
    }
  }

  Future<void> getAuthorization() async {
    await setApiBody(searchCommonRequest.toJson());
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
