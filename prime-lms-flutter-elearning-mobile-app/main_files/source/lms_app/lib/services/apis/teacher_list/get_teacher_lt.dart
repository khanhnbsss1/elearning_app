

import 'package:lms_app/base/widgets/toast_common/toast_utils.dart';

import '../../../../base/base_request_elearning/BaseApiRequest.dart';
import '../../../base/base_request_elearning/models/search_common_request.dart';
import 'models/teacher_list_model.dart';
import 'models/teacher_model.dart';

class GetTeacherList extends BaseApiRequest {
  GetTeacherList():super(
    serviceType: SERVICE_TYPE.USER,
    apiName: ApiName.getInstance().getTeacher,
  );

  Future<List<TeacherDetail>?> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();
    if(result.runtimeType == ResponseCommon)
    {
      return [];
    }
    else
    {
      try {
        TeacherDetailModel teacherListModel = TeacherDetailModel.fromJsonList(result);
        return teacherListModel.data??[];
      } on Exception catch (e) {
        ToastUtils.showToastError(e.toString());
        return [];
      }
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
