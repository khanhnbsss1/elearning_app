import 'dart:convert';

import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/EnumCommon.dart';
import 'package:webkit/base/services/base_request/apiName.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';

import '../../../../base/services/base_request/models/response_error_objects.dart';
import '../add_course_request.dart';
import '../course_list/models/course_models.dart';
import 'add_course_directory_model.dart';

class AddCourseFilterApi extends BaseApiRequest {
  AddCourseFilterApi():super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().addCourseDirectory,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return AddCourseFilterModel(data: []);
    }
    else
    {
      AddCourseFilterModel addCourseFilterModel = AddCourseFilterModel.fromJson(result);
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

