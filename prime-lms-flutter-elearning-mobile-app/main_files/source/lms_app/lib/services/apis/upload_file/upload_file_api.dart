import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';

import '../../../base/base.export.dart';
import '../../../base/widgets/common/alert_dialog/loading.common.dart';
import 'models/upload_file_info.dart';

class UploadAvatarApi extends BaseApiRequest {
  UploadFileInfo fileInfo;

  UploadAvatarApi({required this.fileInfo})
      : super(
          serviceType: SERVICE_TYPE.Storage,
          apiName: ApiName().addUploadFile,
          bodyMethod: BodyMethod.formData,
        );

  Future<UploadFileResponseInfo?> call() async {
    await getAuthorization();
    dynamic data = await postRequestAPI();
    if (data == ResponseCommon) {
      return UploadFileResponseInfo();
    } else {
      UploadFileResponseInfo uploadFileResponseInfo =
      UploadFileResponseInfo.fromJson(data);
      return uploadFileResponseInfo;
    }
    // MonitorLoading().dismiss();
  }

  Future<void> getAuthorization() async {
    // TODO: implement getAuthorization
    await setApiBody({'file': fileInfo.file, 'data': 'avatar'});
  }

  @override
  Future<void> onRequestSuccess(var data) async {
    // TODO: implement onRequestSuccess
    super.onRequestSuccess(data);
  }

  @override
  Future<void> onRequestError(int? statusCode, String? statusMessage) async {
    // TODO: implement onRequestError
    super.onRequestError(statusCode, statusMessage);
  }
}
