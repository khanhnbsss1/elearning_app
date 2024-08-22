
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';

import 'models/grade_info.dart';


class DeleteGradeApi extends BaseApiRequest {
  GradeInfo tagInfo;
  DeleteGradeApi({required this.tagInfo}):super(
    serviceType: SERVICE_TYPE.GRADE,
    apiName: ApiName.getInstance().deleteGrade,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await deleteRequestAPI();
    return result;
  }

  Future<void> getAuthorization() async {
    await setParamsAdd({"gradeId":tagInfo.id});
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
