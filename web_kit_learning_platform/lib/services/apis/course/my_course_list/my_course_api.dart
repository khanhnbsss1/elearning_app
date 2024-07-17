import 'dart:convert';

import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/EnumCommon.dart';
import 'package:webkit/base/services/base_request/apiName.dart';

import '../../../../base/services/base_request/models/response_error_objects.dart';
import '../course_list/models/course_models.dart';

class MyCourseApi extends BaseApiRequest {
  MyCourseApi():super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().getMyCourses,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return CourseResponseModel(content: []);
    }
    else
    {
      CourseResponseModel courseResponseModel = CourseResponseModel.fromJson(result);
      return courseResponseModel;
    }
  }

  Future<void> getAuthorization() async {
    // await setParamsAdd({"type": typeNameToStr[typeName]});
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
