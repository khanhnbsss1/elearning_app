
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
import '../../../base/base_request_elearning/models/search_common_request.dart';
import 'models/test_info.dart';


class GetTestListApi extends BaseApiRequest {
  SearchCommonRequest searchCommonRequest;
  GetTestListApi({required this.searchCommonRequest}):super(
    serviceType: SERVICE_TYPE.TEST,
    apiName: ApiName.getInstance().getTestList,
  );

  Future<TestListResponseModel> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return TestListResponseModel(content: [], total: 0, pageSize: 0, pageNumber: 0);
    }
    else
    {
      TestListResponseModel model = TestListResponseModel.fromList(result);
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
