
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';

import '../../../base/base.export.dart';
import 'models/upload_file_info.dart';

class UploadFileApi extends BaseApiRequest {
  UploadFileInfo fileInfo;
  UploadFileApi({required this.fileInfo}) : super(
      serviceType: SERVICE_TYPE.Storage,
      apiName: ApiName().addUploadFile,
    bodyMethod: BodyMethod.formData,
  );
  Future<UploadFileResponseInfo?> call() async {
    await getAuthorization();
    try{
      MonitorLoading().showLoading(L10nX.getStr.uploading_file);
      dynamic data = await postRequestAPI();
      MonitorLoading().dismiss();
      if(data!=null && data.runtimeType!= ResponseCommon)
        {
          UploadFileResponseInfo uploadFileResponseInfo = UploadFileResponseInfo.fromJson(data);
          return uploadFileResponseInfo;
        }
    }
    catch(e){
      MonitorLoading().dismiss();
      return null;
    }
    return null;
  }

  Future<void> getAuthorization() async {
    // TODO: implement getAuthorization
    await setApiBody({
      'data': fileInfo.getDataType(),
      'fileName': fileInfo.file?.filename??"",
      'file': fileInfo.file,
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
