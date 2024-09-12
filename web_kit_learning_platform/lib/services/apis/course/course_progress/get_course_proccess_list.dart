
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'models/course_proccess_info.dart';

class GetCourseProccessListApi extends BaseApiRequest {
  GetCourseProccessListApi():super(
    serviceType: SERVICE_TYPE.DashBoard,
    apiName: ApiName.getInstance().courseProccess,
  );

  Future<CourseProgressResponseModel> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return CourseProgressResponseModel(content: [], total: 0, pageSize: 10, pageNumber: 0);
    }
    else
    {
      CourseProgressResponseModel model = CourseProgressResponseModel.fromList(result);
      return model;
    }
  }

  Future<void> getAuthorization() async {
    //await setApiBody(searchCommonRequest.toJson());
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
