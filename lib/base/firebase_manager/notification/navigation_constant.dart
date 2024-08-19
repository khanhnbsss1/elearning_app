import 'package:flutter/material.dart';
import '../model/firebase_notìication_data_object.dart';
class NaviConstant {
  /// I. ============== Thông báo ===========================================
  static final NaviConstant _singletonNaviConstant = NaviConstant._internal();
  static NaviConstant get getInstance => _singletonNaviConstant;
  factory NaviConstant() {
    return _singletonNaviConstant;
  }
  NaviConstant._internal();
  bool isNotify = false;
  bool showingInLoginPage = false;
  /// MOBILE
  /// TABLET
  /// 1. Hàm này thực hiện xử lý điều hướng cho ca mobile va tablet khi co notify
  void handleEventTabBlock() {
    if (!isNotify || NaviConstant.getInstance.firebaseRemoteMessageData.data==null) {
      return;
    }
    // Reset trạng thái tab ký duệt về khởi tạo
    MessageType messageType = NaviConstant.getInstance.firebaseRemoteMessageData.getMessageType();
    switch(messageType){
      case MessageType.TOP_UP:
    /*    PaymentDetailPage(transactionId: NaviConstant.getInstance.firebaseRemoteMessageData.data!.transactionId!
        ).show(InstanceManager().navigatorKey.currentContext!);*/
        // TODO: Handle this case.
        break;
      case MessageType.NONE:
        // TODO: Handle this case.
        break;
      case MessageType.EXTEND:
        // TODO: Handle this case.
      case MessageType.PAY_BY_VOUCHER:
        // TODO: Handle this case.
      case MessageType.PROVIDE_VOUCHER:
        // TODO: Handle this case.
      case MessageType.RECEIVE_VOUCHER:
        // TODO: Handle this case.
      case MessageType.REFUND_VOUCHER:
        // TODO: Handle this case.
    }
    NaviConstant.getInstance.resetValueNotification();
  }

  /// 2. Hàm này thực hiện điều hướng đến tab văn bản (chỉ dùng cho tablet)
  /// III. =========== data notification body ============
  FirebaseMessageData firebaseRemoteMessageData = FirebaseMessageData();
  ///reset giá trị notify về mặc định
  void resetValueNotification() {
    isNotify = false;
    firebaseRemoteMessageData = FirebaseMessageData();
  }
  static void closeDigitalNotifyPage(BuildContext context){
    Navigator.of(context).pop();
  }
}
