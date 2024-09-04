
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';

import '../test/models/test_info.dart';


class GetTestFilterApi extends BaseApiRequest {
  GetTestFilterApi():super(
    serviceType: SERVICE_TYPE.TEST,
    apiName: ApiName.getInstance().getTestFilter,
  );

  Future<TestListResponseModel> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return TestListResponseModel(content: [], total: 0, pageSize: 10, pageNumber: 0);
    }
    else
    {
      FilterResponseModel model = FilterResponseModel.fromJsonList(result);
      TestListResponseModel testListResponseModel = TestListResponseModel.fromTestFilter(model);
      return testListResponseModel;
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
