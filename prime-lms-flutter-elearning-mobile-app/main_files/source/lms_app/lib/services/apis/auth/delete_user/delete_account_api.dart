import 'package:lms_app/base/author/user_helper.dart';
import 'package:lms_app/base/base_request_elearning/BaseApiRequest.dart';
import 'package:lms_app/base/widgets/toast_common/toast_utils.dart';
import 'package:lms_app/models/user/UserProfile.dart';

class DeleteAccountApi extends BaseApiRequest {
  DeleteAccountApi()
      : super(
    serviceType: SERVICE_TYPE.USER,
    apiName: ApiName().deleteAccount,
    bodyMethod: BodyMethod.formData,
  );

  Future<void> call() async {
    await getAuthorization();
    dynamic data = await deleteRequestAPI();
    if (data == ResponseCommon) {
    } else {
      ToastUtils.showToastError('error');
    }
    // MonitorLoading().dismiss();
  }

  Future<void> getAuthorization() async {
    // TODO: implement getAuthorization
    UserProfile? userProfile = UserManager().getUserProfile();
    await setApiBody({'username': userProfile!.userName, 'type': userProfile.roleName});
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
