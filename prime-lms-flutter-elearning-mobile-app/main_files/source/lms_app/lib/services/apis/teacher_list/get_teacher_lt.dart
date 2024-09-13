

import '../../../../base/base_request_elearning/BaseApiRequest.dart';
import '../../../base/base_request_elearning/models/search_common_request.dart';
import 'models/teacher_list_model.dart';

class GetTeacherList extends BaseApiRequest {
  SearchCommonRequest searchCommonRequest;
  GetTeacherList({required this.searchCommonRequest}):super(
    serviceType: SERVICE_TYPE.USER,
    apiName: ApiName.getInstance().getUserList,
  );

  Future<dynamic> call() async {
    await getAuthorization();
    dynamic result = await getRequestAPI();
    if(result.runtimeType == ResponseCommon)
    {
      return TeacherListModel(data: []);
    }
    else
    {
      TeacherListModel teacherListModel = TeacherListModel.fromJsonList(result);
      return teacherListModel.data;
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
