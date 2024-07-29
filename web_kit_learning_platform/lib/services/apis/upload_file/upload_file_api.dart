import 'dart:convert';

import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/services/apis/words/word_info.dart';

import '../../../base/base.export.dart';
import 'models/upload_file_info.dart';

class UploadFileApi extends BaseApiRequest {
  UploadFileInfo fileInfo;
  UploadFileApi({required this.fileInfo}) : super(
      serviceType: SERVICE_TYPE.Storage,
      apiName: ApiName().addUploadFile,
    bodyMethod: BodyMethod.formData,
  );
  Future<dynamic> call() async {
    await getAuthorization();
    try{
      MonitorLoading().showLoading(L10nX.getStr.uploading_file);
      dynamic data = await postRequestAPI();
      MonitorLoading().dismiss();
      return data;
    }
    catch(e){
      MonitorLoading().dismiss();
      return "";
    }
  }

  Future<void> getAuthorization() async {
    // TODO: implement getAuthorization
    await setApiBody({
      'data': fileInfo.getDataType(),
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
