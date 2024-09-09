
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';

import '../../../base/base.export.dart';
import '../../../base/widgets/common/alert_dialog/loading.common.dart';
import 'models/upload_file_info.dart';

class UploadAvatarApi extends BaseApiRequest {
  UploadFileInfo fileInfo;
  UploadAvatarApi({required this.fileInfo}) : super(
      serviceType: SERVICE_TYPE.USER,
      apiName: ApiName().addUploadFile,
    bodyMethod: BodyMethod.formData,
  );
  Future<UploadFileResponseInfo?> call() async {
    await getAuthorization();
    try{
      dynamic data = await postRequestAPI();
      if(data!=null && data.runtimeType!= ResponseCommon)
        {
          UploadFileResponseInfo uploadFileResponseInfo = UploadFileResponseInfo.fromJson(data);
          return uploadFileResponseInfo;
        }
    }
    catch(e){
      // MonitorLoading().dismiss();
      return null;
    }
    return null;
  }

  Future<void> getAuthorization() async {
    // TODO: implement getAuthorization
    await setApiBody({
      'avatar': fileInfo.file
    });
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
