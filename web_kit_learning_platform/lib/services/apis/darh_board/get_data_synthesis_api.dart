
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';

import 'models/synthesisInfo.dart';

class GetDataSynthesisApi extends BaseApiRequest {
  GetDataSynthesisApi():super(
    serviceType: SERVICE_TYPE.DashBoard,
    apiName: ApiName.getInstance().getDataSynthesis,
  );

  Future<SynthesisSummaryInfo> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return SynthesisSummaryInfo();
    }
    else
    {
      SynthesisSummaryInfo responseModel = SynthesisSummaryInfo.fromJson(result.first);
      return responseModel;
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
