
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
// import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import '../../../../base/base_request_elearning/models/search_common_request.dart';
import '../models/lesson_info.dart';

class GetLessonListApi extends BaseApiRequest {
  SearchCommonRequest searchCommonRequest;
  GetLessonListApi({required this.searchCommonRequest}):super(
    serviceType: SERVICE_TYPE.LESSON,
    apiName: ApiName.getInstance().getLessonList,
  );

  Future<LessonListResponseModel> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return LessonListResponseModel(content: [], total: 0, pageSize: 0, pageNumber: 0);
    }
    else
    {
      LessonListResponseModel paymentHistoryResponseModel = LessonListResponseModel.fromJson(result);
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
