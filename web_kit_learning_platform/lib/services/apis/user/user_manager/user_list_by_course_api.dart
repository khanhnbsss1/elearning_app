
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';

class GetUserListByCourseApi extends BaseApiRequest {
  SearchCommonRequest searchCommonRequest;
  GetUserListByCourseApi({required this.searchCommonRequest}):super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().getUserListCourses,
  );

  Future<UserListResponseModel> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return UserListResponseModel(content: [], total: 0, pageSize: 10, pageNumber: 0);
    }
    else
    {
      UserListResponseModel paymentHistoryResponseModel = UserListResponseModel.fromJson(result);
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
