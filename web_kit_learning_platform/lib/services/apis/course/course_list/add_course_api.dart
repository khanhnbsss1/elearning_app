import 'dart:convert';

import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/services/base_request/EnumCommon.dart';
import 'package:webkit/base/services/base_request/apiName.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';

import '../../../../base/services/base_request/models/response_error_objects.dart';
import '../add_course_request.dart';
import '../course_list/models/course_models.dart';

class AddCourseApi extends BaseApiRequest {
  AddCourseRequest addCourseRequest;
  AddCourseApi({required this.addCourseRequest}):super(
    serviceType: SERVICE_TYPE.COURSE,
    apiName: ApiName.getInstance().createCourse,
      requestBody: {
        'image': addCourseRequest.image,
        'data': {
          'id': addCourseRequest.id,
          'name': addCourseRequest.name,
          'producer_name': addCourseRequest.producerName,
          'language': addCourseRequest.language,
          'introduction': addCourseRequest.introduction,
          'payment': addCourseRequest.payment,
          'rate_point': addCourseRequest.ratePoint,
          'durian': addCourseRequest.durian,
          'course_mode': addCourseRequest.courseMode,
          'grade_name': addCourseRequest.gradeName,
          'category_id': addCourseRequest.categoryId,
          'is_standard': addCourseRequest.isStandard,
          'category_name': addCourseRequest.categoryName,
          'video_preview': addCourseRequest.videoPreview,
          'info_obj': addCourseRequest.infoObj,
          'info_result': addCourseRequest.infoResult,
          'is_active': addCourseRequest.isActive,
          'accompany_course': addCourseRequest.accompanyCourse,
        },
        'tags': addCourseRequest.tags,
      }
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await postRequestAPI();
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
