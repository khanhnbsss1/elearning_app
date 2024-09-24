
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import '../course_list/models/course_models.dart';

class GetCourseInterestListApi extends BaseApiRequest {
  SearchCommonRequest searchCommonRequest;
  GetCourseInterestListApi({required this.searchCommonRequest}):super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().getCourseInterestList,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return CourseResponseModel(content: [], total: 0, pageSize: 10, pageNumber: 0);
    }
    else
    {
      CourseResponseModel paymentHistoryResponseModel = CourseResponseModel.fromJsonList(result);
      return paymentHistoryResponseModel;
    }
  }

  Future<void> getAuthorization() async {
    UserProfile? userProfile = UserManager().getUserProfile();
    if(userProfile!=null) {
      searchCommonRequest = searchCommonRequest.copyWith(userId: userProfile.id);
    }
     await setParamsAdd(searchCommonRequest.toJson());
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
