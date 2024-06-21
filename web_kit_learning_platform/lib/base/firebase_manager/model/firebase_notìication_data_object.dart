
import '../../image_manager/images_constant.dart';

enum MessageType
{
  NONE,
}
Map<String, MessageType> stringToMessageType={
  "NONE":MessageType.NONE,

};
Map<MessageType, String> messageTypeToIconString={
  MessageType.NONE:ImageManager.ic_information_png,
};
class FirebaseMessageData {
  String? type;
  MessageData? data;

  FirebaseMessageData({this.type, this.data});

  FirebaseMessageData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? MessageData.fromJson(json['data']) : null;
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (this.data != null) {
      data['data'] =data;
    }
    return data;
  }
  MessageType getMessageType(){
    return stringToMessageType[type]??MessageType.NONE;
  }
  
}

class MessageData {
  int? bookingId;
  String? transactionId;
  String?uid;
  MessageData({this.bookingId, this.transactionId, this.uid});

  MessageData.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    transactionId = json['payTransactionId']??json['transactionId'].toString();
    uid = json['uid'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookingId'] = bookingId;
    data['payTransactionId'] = transactionId;
    data['uid'] = uid;
    return data;
  }
}
