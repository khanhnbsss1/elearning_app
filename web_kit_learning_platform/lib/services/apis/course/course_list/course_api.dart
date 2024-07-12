import 'dart:convert';

import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/EnumCommon.dart';
import 'package:webkit/base/services/base_request/apiName.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';

import '../../../../base/services/base_request/models/response_error_objects.dart';
import '../course_list/models/course_models.dart';

class CourseApi extends BaseApiRequest {
  SearchCommonRequest searchCommonRequest;
  CourseApi({required this.searchCommonRequest}):super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().getCourseList,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();

    if(result.runtimeType == ResponseCommon)
    {
      return CourseResponseModel(content: [], total: 0, pageSize: 0, pageNumber: 0);
    }
    else
    {
      CourseResponseModel paymentHistoryResponseModel = CourseResponseModel.fromJson(result);
      return paymentHistoryResponseModel;
    }
  }

  Future<void> getAuthorization() async {
    UserProfile? userProfile = await UserManager().getUserProfile();
    if(userProfile!=null) {
      searchCommonRequest = searchCommonRequest.copyWith(userId: userProfile.id);
    }
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
