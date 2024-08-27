import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';

import 'get_course_directory_model.dart';

class GetAddCourseFilterApi extends BaseApiRequest {
  GetAddCourseFilterApi():super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().addCourseDirectory,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return GetAddCourseFilterModel(data: []);
    }
    else
    {
      GetAddCourseFilterModel addCourseFilterModel = GetAddCourseFilterModel.fromJson(result);
      return addCourseFilterModel;
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

