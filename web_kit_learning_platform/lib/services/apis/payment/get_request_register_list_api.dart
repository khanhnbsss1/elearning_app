
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';

import 'models/request_registered_info.dart';

class GetRequestRegisteredListApi extends BaseApiRequest {
  SearchCommonRequest searchCommonRequest;
  GetRequestRegisteredListApi({required this.searchCommonRequest}):super(
    serviceType: SERVICE_TYPE.QUIZ,
    apiName: ApiName.getInstance().getQuizList,
  );

  Future<RequestRegisteredListResponseModel> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return RequestRegisteredListResponseModel(content: [], total: 0, pageSize: 10, pageNumber: 0);
    }
    else
    {
      RequestRegisteredListResponseModel model = RequestRegisteredListResponseModel.fromJson(result);
      return model;
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

