
import 'package:easy_localization/easy_localization.dart';

import '../../../base/base_request_elearning/BaseApiRequest.dart';
import '../../../base/widgets/toast_common/toast_utils.dart';
import 'models/score_info.dart';
import 'models/score_result.dart';


class CreateScoreApi extends BaseApiRequest {
  ScoresInfo info;
  CreateScoreApi({required this.info}):super(
    serviceType: SERVICE_TYPE.Scores,
    apiName: ApiName.getInstance().createScore,
  );

  Future<ScoreResultInfo?> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();
    if(result.runtimeType == ResponseCommon)
    {
      return null;
    }
    else
      {
        ScoreResultInfo scoreResultInfo = ScoreResultInfo.fromJson(result);
        return scoreResultInfo;
      }
  }

  Future<void> getAuthorization() async {
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

