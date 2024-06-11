import 'package:lms_app/base/base.export.dart';

class BaseAPIResponse {
  int? status;
  String? datetime;
  String? message;
  String? messageCode;
  var result;
  String? error;
  BaseAPIResponse(
      {this.status,
      this.datetime,
      this.message,
      this.messageCode,
      this.result});

  BaseAPIResponse.fromJson(Map<String, dynamic> json) {
    status = json['status']??(json['errorCode']!=null?int.tryParse(json['errorCode']):400);
    datetime = json['datetime']??"";
    message = json['message']??"";
    messageCode =json['messageCode']?? (json['success']!=null?json['success'].toString():"");
    try {
      result = json['data']??json['result']??"";
    } catch (e) {
       FileUtils.PrintLog(e);
    }
  }
  BaseAPIResponse.withError(String errorMessage) {
    error = errorMessage;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = status;
    data['datetime'] = datetime;
    data['message'] = message;
    data['messageCode'] = messageCode;
    if (result != null) {
      data['result'] = result;
    }
    return data;
  }

  void setResultJsonString(String result) {
    result = result;
  }

  String? getResultJsonString() {
    return result;
  }
}
