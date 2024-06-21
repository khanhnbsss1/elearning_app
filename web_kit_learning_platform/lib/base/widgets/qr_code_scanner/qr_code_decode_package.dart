

import 'dart:convert';

import 'package:webkit/base/base.export.dart';
import 'package:flutter/material.dart';

enum QrCodeType{
  none
}
Map<QrCodeType, String>qrCodeTypeToString ={
  QrCodeType.none:"none",

};
Map<String, QrCodeType> stringToQrCodeType={
  "none":QrCodeType.none,
};
class QrCodeModel {
  QrCodeType? scannerType;
  Map<String, dynamic>? data;
  bool? decodeResult;

  QrCodeModel({ this.scannerType, this.data}){
    decodeResult??=false;
  }

  QrCodeModel.fromJson(Map<String, dynamic> json) {
    try{
      scannerType = stringToQrCodeType[(json['type']??'none')];
      data = json['data'];
      decodeResult = true;
    }
    catch(e)
    {
      decodeResult = false;
    }

  }

  QrCodeType getQrCodeType(){
    return scannerType??QrCodeType.none;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = qrCodeTypeToString[getQrCodeType()];
    data['data'] = this.data;
    return data;
  }
  String toString() {
    String dataStr = base64.encode(utf8.encode(jsonEncode(toJson())));
    return dataStr;
  }
}

class QRCodeDecodePackage{
  String result;
  BuildContext context;
  QRCodeDecodePackage(
      {
        required this.result,
        required this.context
      }){
    FileUtils.PrintLog(result);


  }
  void handlePackage(){
    QrCodeModel qrCodeModel =QrCodeModel.fromJson(jsonDecode(result??""));
    if(qrCodeModel.decodeResult??false)
    {
      QrCodeType qrCodeType = qrCodeModel.getQrCodeType();
      switch(qrCodeType)
      {
        
        case QrCodeType.none:
        // TODO: Handle this case.
          break;
      }
    }

  }
  dynamic getObjectDecode(){
    QrCodeModel qrCodeModel =QrCodeModel.fromJson(jsonDecode(result??""));
    if(qrCodeModel.decodeResult??false)
    {
      QrCodeType qrCodeType = qrCodeModel.getQrCodeType();
      switch(qrCodeType)
      {
        case QrCodeType.none:
        // TODO: Handle this case.
          break;
      }
    }
  }
}