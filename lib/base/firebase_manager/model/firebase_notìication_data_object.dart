

enum MessageType
{
  TOP_UP, /// nap vao vi
  EXTEND, /// gia han thiet bi
  PAY_BY_VOUCHER,/// nguoi dung thanh toan bang 1 voucher
  PROVIDE_VOUCHER, /// Nap tien vao voucher
  RECEIVE_VOUCHER, /// thong bao cua nguoi dung, khi duoc doi tac nap voucher
  REFUND_VOUCHER, /// thong bao cua doi tac, khi duoc doi tac huy lien ket vi voi nguoi dung
  NONE,
}
Map<String, MessageType> stringToMessageType={
  "TOP_UP":MessageType.TOP_UP,
  "EXTEND":MessageType.EXTEND,
  "PAY_BY_VOUCHER":MessageType.PAY_BY_VOUCHER,
  "PROVIDE_VOUCHER":MessageType.PROVIDE_VOUCHER,
  "RECEIVE_VOUCHER":MessageType.RECEIVE_VOUCHER,
  "REFUND_VOUCHER":MessageType.REFUND_VOUCHER,
  "NONE":MessageType.NONE,

};
Map<MessageType, String> messageTypeToIconString={
 /* MessageType.TOP_UP:ImagesNameConst.ic_topup2_png,
  MessageType.EXTEND:ImagesNameConst.ic_topup2_png,
  MessageType.PAY_BY_VOUCHER:ImagesNameConst.ic_topup2_png,
  MessageType.PROVIDE_VOUCHER:ImagesNameConst.ic_topup2_png,
  MessageType.RECEIVE_VOUCHER:ImagesNameConst.ic_topup2_png,
  MessageType.REFUND_VOUCHER:ImagesNameConst.ic_topup2_png,
  MessageType.NONE:ImagesNameConst.ic_information_png,*/
  
  
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


class DeviceAlarmObjectData {
  String? trkTime;
  int? timeStampUtc;
  int? deviceId;
  int? userId;
  String? userName;
  String? imei;
  int? code;
  double? value;
  String? message;
  double? latitude;
  double? longitude;
  String? address;

  DeviceAlarmObjectData(
      {this.trkTime,
        this.timeStampUtc,
        this.deviceId,
        this.userId,
        this.userName,
        this.imei,
        this.code,
        this.value,
        this.message,
        this.latitude,
        this.longitude,
        this.address});

  DeviceAlarmObjectData.fromJson(Map<String, dynamic> json) {
    trkTime = json['TrkTime']??"";
    timeStampUtc = json['TimeStampUtc']??0;
    deviceId = json['DeviceId']??0;
    userId = json['UserId']??"";
    userName = json['UserName']??"";
    imei = json['Imei']??"";
    code = json['Code']??0;
    value = double.parse((json['Value']??0).toString());
    message = json['Message']??"";
    latitude = double.parse((json['Latitude']??0).toString());
    longitude = double.parse((json['Longitude']??0).toString());
    address = json['Address']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TrkTime'] =trkTime;
    data['TimeStampUtc'] =timeStampUtc;
    data['DeviceId'] =deviceId;
    data['UserId'] =userId;
    data['UserName'] =userName;
    data['Imei'] =imei;
    data['Code'] =code;
    data['Value'] =value;
    data['Message'] =message;
    data['Latitude'] =latitude;
    data['Longitude'] =longitude;
    data['Address'] =address;
    return data;
  }
} /// canh bao thong tin thiet bi
 /// canh bao ra vao vung
class GeofenceAlert {
  String? time;
  String? updateTime;
  int? deviceId;
  int? userId;
  int? ruleId;
  double? latitude;
  double? longitude;
  String? address;
  double? speed;
  int? geofenceType;
  int? geofenceId;
  String? geofenceName;

  GeofenceAlert(
      {this.time,
        this.updateTime,
        this.deviceId,
        this.userId,
        this.ruleId,
        this.latitude,
        this.longitude,
        this.address,
        this.speed,
        this.geofenceType,
        this.geofenceId,
        this.geofenceName});

  GeofenceAlert.fromJson(Map<String, dynamic> json) {
    time = json['Time'];
    updateTime = json['UpdateTime'];
    deviceId = json['DeviceId'];
    userId = json['UserId'];
    ruleId = json['RuleId'];
    latitude = double.parse((json['Latitude']??0).toString());
    longitude = double.parse((json['Longitude']??0).toString());
    address = json['Address']??"";
    speed = double.parse((json['Speed']??0).toString());
    geofenceType = json['GeofenceType'];
    geofenceId = json['GeofenceId']??0;
    geofenceName = json['GeofenceName']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Time'] =time;
    data['UpdateTime'] =updateTime;
    data['DeviceId'] =deviceId;
    data['UserId'] =userId;
    data['RuleId'] =ruleId;
    data['Latitude'] =latitude;
    data['Longitude'] =longitude;
    data['Address'] =address;
    data['Speed'] =speed;
    data['GeofenceType'] =geofenceType;
    data['GeofenceId'] =geofenceId;
    data['GeofenceName'] =geofenceName;
    return data;
  }
}

class TemperatureAlert{} /// canh bao nhiet do