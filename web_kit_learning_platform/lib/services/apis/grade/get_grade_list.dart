
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';

import 'models/grade_info.dart';

class GetGradeListApi extends BaseApiRequest {
  GetGradeListApi():super(
    serviceType: SERVICE_TYPE.GRADE,
    apiName: ApiName.getInstance().getGradeList,
  );

  Future<GradeListResponseModel> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return GradeListResponseModel(content: [], total: 0, pageSize: 10, pageNumber: 0);
    }
    else
    {
      GradeListResponseModel paymentHistoryResponseModel = GradeListResponseModel.fromList(result);
      return paymentHistoryResponseModel;
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
