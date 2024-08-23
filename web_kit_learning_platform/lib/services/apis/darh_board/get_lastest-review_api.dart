
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';

import 'models/synthesisInfo.dart';
import 'models/synthesis_students_info.dart';

class GetLastReviewApi extends BaseApiRequest {
  int? limit;
  GetLastReviewApi():super(
    serviceType: SERVICE_TYPE.DashBoard,
    apiName: ApiName.getInstance().getLastReview,
  ){
    limit??=10;
  }

  Future<SynthesisStudentInfoResponseModel> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return SynthesisStudentInfoResponseModel();
    }
    else
    {
      SynthesisStudentInfoResponseModel responseModel = SynthesisStudentInfoResponseModel.fromJson(result);
      return responseModel;
    }
  }

  Future<void> getAuthorization() async {
    await setParamsAdd({"limit":limit});
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
