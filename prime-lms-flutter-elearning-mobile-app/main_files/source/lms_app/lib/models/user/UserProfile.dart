
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lms_app/enviroments/flavor_settings.dart';
import 'package:lms_app/models/user/userInfo.dart';
import 'package:lms_app/theme/colors_app.dart';

enum UserType{
  none,
  DISTRIBUTOR, /// 1  admin
  PARTNER,///2  doi tac
  CUSTOMER ///3  nguoi dung end user 
}
class UserProfile {
  int? id;
  int? parentId;
  int? aliasId;
  String? path;
  String? username;
  String? password;
  int? type;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? description;
  int? status;
  String? createdAt;
  String? createdBy;
  String? updatedBy;
  String? updatedAt;
  int? totalDevice;
  String? timezone;
  String? language;
  String? unitDistance;
  String? unitVolume;
  String? unitTemperature;
  String? unitWeight;
  String? dateFormat;
  String? timeFormat;
  String? permission;
  String? pageMain;
  int? roleId;
  String? currencyUnit;
  bool? hasChild;
  String? roleName;
  String? roleKey;
  int? walletBalance;
  bool? hasPinCode;
  String? pinCode;
  int? rfidTagId;
  List<DeviceFavouriteSummaryInfo>? deviceFavouriteInfos;
  int? servicePriceId;
  ServicePriceInfo? servicePriceInfo;
  String? partnerCode;
  List<int>? partnerIds;

  UserProfile(
      {this.id,
        this.parentId,
        this.aliasId,
        this.path,
        this.username,
        this.type,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.description,
        this.status,
        this.createdAt,
        this.createdBy,
        this.updatedBy,
        this.updatedAt,
        this.totalDevice,
        this.timezone,
        this.language,
        this.unitDistance,
        this.unitVolume,
        this.unitTemperature,
        this.unitWeight,
        this.dateFormat,
        this.timeFormat,
        this.permission,
        this.pageMain,
        this.roleId,
        this.currencyUnit,
        this.hasChild,
        this.roleName,
        this.roleKey,
        this.walletBalance,
        this.hasPinCode,
        this.rfidTagId,
        this.deviceFavouriteInfos,
        this.servicePriceId,
        this.servicePriceInfo,
        this.partnerCode,
        this.password,
        this.partnerIds,
        this.pinCode
      });

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parentId'];
    aliasId = json['aliasId'];
    path = json['path'];
    username = json['username'];
    type = json['type'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    description = json['description'];
    status = json['status'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    updatedAt = json['updatedAt'];
    totalDevice = json['totalDevice'];
    timezone = json['timezone'];
    language = json['language'];
    unitDistance = json['unitDistance'];
    unitVolume = json['unitVolume'];
    unitTemperature = json['unitTemperature'];
    unitWeight = json['unitWeight'];
    dateFormat = json['dateFormat'];
    timeFormat = json['timeFormat'];
    permission = json['permission'];
    pageMain = json['pageMain'];
    roleId = json['roleId'];
    currencyUnit = json['currencyUnit'];
    hasChild = json['hasChild'];
    roleName = json['roleName'];
    roleKey = json['roleKey'];
    walletBalance = json['walletBalance'];
    hasPinCode = json['pinCode'];
    pinCode = json['pinCode_str'];
    rfidTagId = json['rfidTagId'];
    if (json['deviceFavouriteInfos'] != null) {
      deviceFavouriteInfos = <DeviceFavouriteSummaryInfo>[];
      json['deviceFavouriteInfos'].forEach((v) {
        deviceFavouriteInfos!.add(DeviceFavouriteSummaryInfo.fromJson(v));
      });
    }
    servicePriceId = json['servicePriceId'];
    servicePriceInfo = json['servicePriceInfo'] != null
        ? ServicePriceInfo.fromJson(json['servicePriceInfo'])
        : null;
    partnerCode = json['partnerCode'];
    partnerIds = (json['partnerIds']??[]).cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parentId'] = parentId;
    data['aliasId'] = aliasId;
    data['path'] = path;
    data['username'] = username;
    data['type'] = type;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['description'] = description;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['updatedAt'] = updatedAt;
    data['totalDevice'] = totalDevice;
    data['timezone'] = timezone;
    data['language'] = language;
    data['unitDistance'] = unitDistance;
    data['unitVolume'] = unitVolume;
    data['unitTemperature'] = unitTemperature;
    data['unitWeight'] = unitWeight;
    data['dateFormat'] = dateFormat;
    data['timeFormat'] = timeFormat;
    data['permission'] = permission;
    data['pageMain'] = pageMain;
    data['roleId'] = roleId;
    data['currencyUnit'] = currencyUnit;
    data['hasChild'] = hasChild;
    data['roleName'] = roleName;
    data['roleKey'] = roleKey;
    data['walletBalance'] = walletBalance;
    data['hasPinCode'] = hasPinCode;
    data['pinCode_str'] = pinCode;
    data['rfidTagId'] = rfidTagId;
    if (deviceFavouriteInfos != null) {
      data['deviceFavouriteInfos'] =
          deviceFavouriteInfos!.map((v) => v.toJson()).toList();
    }
    data['servicePriceId'] = servicePriceId;
    if (servicePriceInfo != null) {
      data['servicePriceInfo'] = servicePriceInfo!.toJson();
    }
    data['partnerCode'] = partnerCode;
    data['partnerIds'] = partnerIds;
    return data;
  }
  Map<String, dynamic> toJsonForQrCode(){
  final Map<String, dynamic> data = <String, dynamic>{};
  if(FlavorSettings().getFlavorType()== FlavorType.elearningLms)
    {
      data['id'] = id;
    }
  else
    {
      data['partnerCode'] = partnerCode;
    }
  data['username'] = username;
  data['name'] = name;
  data['phone'] = phone;
  data['address'] = address;
  data['type'] = type;
  
  return data;
}
  UserProfile.fromJsonQRCode(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    type = json['type'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    partnerCode = json['partnerCode'];
  }

  UserProfile.initial(){
    id =null;
    parentId= null;
    aliasId= null;
    path= "";
    username= "";
    password= "";
    type= 0;
    name= "";
    email= "";
    phone= "";
    description= "";
    status= 0;
    createdAt= DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    totalDevice=0;
    timezone= "";
    language= "";
    unitDistance= "";
    unitVolume= "";
    unitTemperature= "";
    unitWeight= "";
    dateFormat= "";
    timeFormat= "";
    permission= "";
    pageMain= "";
    roleId= 3;
    roleName= "";
    roleKey ="";
    hasChild= false;
    hasPinCode = true;
    pinCode="";
    partnerCode=null;
  }

  UserInfo convertToUserInfo(UserInfo oldUserInfo)
  {
    UserInfo userInfo = oldUserInfo;
    userInfo.username = username;
    userInfo.userId = id.toString();
    userInfo.phoneNumber = phone;
    userInfo.address = "";
    userInfo.password = password;
    userInfo.expiredAt = oldUserInfo.expiredAt;
    userInfo.rules = oldUserInfo.rules;
    userInfo.token = oldUserInfo.token;
    userInfo.tokenFireBase = oldUserInfo.tokenFireBase;
    return userInfo;
  }
  bool isParent(){
    bool isParent = false;
    if(type!=null)
    {
      if(type == 0 || type == 1) {
        isParent = true;
      } else
      {
        if(hasChild == true) {
          isParent = true;
        } else {
          isParent = false;
        }
      }
    }
    return isParent;
  }
  UserType getUserType(){
    return UserType.values.elementAt(type??0);
  }
  String getActiveStatusKey()
  {
    if(status ==1) {
      return "str_activated";
    } else {
      return "str_no_activated";
    }
  }
  Color getColorByType(){
    Color colorType = Colors.orange;
    if(type!=null)
    {
      if(type == 0 || type == 1) {
        colorType = ColorConst.mainColor;
      } else {
        colorType = Colors.orange;
      }
    }
    return colorType;
  }
}

class ServicePriceInfo {
  int? id;
  String? name;
  int? userId;
  int? price;
  double? discount;
  String? description;
  String? createdAt;

  ServicePriceInfo(
      {this.id,
        this.name,
        this.userId,
        this.price,
        this.discount,
        this.description,
        this.createdAt});

  ServicePriceInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['userId'];
    price = (json['price']??0).toInt();
    discount = (json['discount']??0).toDouble();
    description = json['description'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['userId'] = userId;
    data['price'] = price;
    data['discount'] = discount;
    data['description'] = description;
    data['createdAt'] = createdAt;
    return data;
  }

}

class DeviceFavouriteSummaryInfo {
  int? id;
  int? deviceId;
  int? userId;

  DeviceFavouriteSummaryInfo({this.id, this.deviceId, this.userId});

  DeviceFavouriteSummaryInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['deviceId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] =id;
    data['deviceId'] =deviceId;
    data['userId'] =userId;
    return data;
  }
}


class RecentUserProfileList {
  List<UserProfile>? recentList;

  RecentUserProfileList({this.recentList}){
    recentList??=[];
  }

  RecentUserProfileList.fromJson(Map<String, dynamic> json) {
    recentList = <UserProfile>[];
    if (json['RecentUser'] != null) {
      json['RecentUser'].forEach((v) {
        recentList!.add(UserProfile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recentList != null) {
      data['RecentUser'] = recentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
