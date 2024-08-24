
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/darh_board/request_model/dash_board_search_model.dart';

import 'models/subscription_purchases_info.dart';
import 'models/synthesisInfo.dart';
import 'models/synthesis_students_info.dart';
import 'models/top_courses_info.dart';
import 'models/user_registration_info.dart';

class GetUserRegistrationApi extends BaseApiRequest {
  DashboardSearchModel dashboardSearchModel;
  GetUserRegistrationApi({required this.dashboardSearchModel}):super(
    serviceType: SERVICE_TYPE.DashBoard,
    apiName: ApiName.getInstance().getUserRegistration,
  );

  Future<UserRegistrationInfoResponseModel> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return UserRegistrationInfoResponseModel();
    }
    else
    {
      UserRegistrationInfoResponseModel responseModel = UserRegistrationInfoResponseModel.fromJsonList(result);
      return responseModel;
    }
  }

  Future<void> getAuthorization() async {
    await setParamsAdd(dashboardSearchModel.toJson());
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
