
import 'package:webkit/base/helper/date_time/date_time_helper.dart';
import 'package:webkit/base/services/base_request/models/page_model.dart';

enum UserType{
  none,
  Teacher,///giao vien
  User, /// hoc vien
  Admin, ///   admin
}
Map<UserType, String>userTypeToStr={
  UserType.none:"None",
  UserType.Teacher:"Teacher",
  UserType.User:"User",
  UserType.Admin:"Admin",
};
class UserProfile {
  int? id;
  String? fullName;
  String? userName;
  String? bankAccount;
  String? bankName;
  String? identityId;
  String? gender;
  String? birthday;
  String? phoneNumber;
  String? avatar;
  String? typeName;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? countryName;
  String? position;
  String? email;
  String? password;

  List<String>? permissionList;
  String? permission;
  String?roleId;
  String?roleName;
  String? accountId;
  UserProfile(
      {this.id,
        this.fullName,
        this.userName,
        this.bankAccount,
        this.bankName,
        this.identityId,
        this.gender,
        this.birthday,
        this.phoneNumber,
        this.avatar,
        this.typeName,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy,
        this.countryName,
        this.position,
        this.email,
        this.permissionList,
        this.roleId,
        this.permission,
        this.password,
        this.roleName,
        this.accountId
      });

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName']??json['fullname'];
    userName = json['user_name'];
    bankAccount = json['bank_account'];
    bankName = json['bank_name'];
    identityId = json['identity_id'];
    gender = json['gender'];
    DateTime time =  DateTimeHelper.stringToDate(birthday??"" ,currentTypeDate:  DateTimeHelper.ddMMYYYYHHMMSS)??DateTime.now();
    birthday = DateTimeHelper.dateFormat(date: time,dateType: DateTimeHelper.yyyyMMDD );
    phoneNumber = json['phone_number'];
    avatar = json['avatar'];
    typeName = json['type_name'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    accountId = json['account_id'];
    countryName = json['country_name'];
    position = json['position'];
    email = json['email'];
    password=json['password'];
    permission=json['permissions']??'';
    permissionList = [];
    if(permission!=null && (permission??'').isNotEmpty)
      {
        permissionList = (json['permissions'] as String).split(',');
      }
    roleId = json['role_id']??json['roleId'];
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName??"";
    data['user_name'] = (userName??"").trim();
    data['username'] = (userName??"").trim();
    data['bank_account'] = bankAccount??"";
    data['bank_name'] = bankName??"";
    //data['identity_id'] = identityId;
    data['gender'] = gender??"";
    data['birthday'] = birthday??"";
    data['phone_number'] = (phoneNumber??"").trim();
    data['avatar'] = avatar??"";
    data['type_name'] = (typeName??"").isNotEmpty?typeName:"User";
    //data['created_at'] = createdAt??"";
    //data['created_by'] = createdBy??"";
    //data['updated_at'] = updatedAt??"";
    //data['updated_by'] = updatedBy??"";
    data['country_name'] = countryName??"";
    data['position'] = position??"";
    data['email'] = (email??"").trim();
    data['password'] = password;
    data['permissions'] = permission;
    data['roleId'] = roleId;
    //data['roleName'] = (roleName??'').trim();
    //data['account_id'] = accountId;

    return data;
  }
  List<String> getPermission(){
    return permissionList??[];
  }

  UserProfile copyWith({
    int? id,
    String? fullName,
    String? userName,
    String? bankAccount,
    String? bankName,
    String? identityId,
    String? gender,
    String? birthday,
    String? phoneNumber,
    String? avatar,
    String? typeName,
    String? createdAt,
    String? createdBy,
    String? updatedAt,
    String? updatedBy,
    String? countryName,
    String? position,
    String? email,
    List<String>? permissionList,
    String? permission,
    String?roleId,
    String?roleName,
    String?password
  }) {
    return UserProfile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userName: userName ?? this.userName,
      bankAccount: bankAccount ?? this.bankAccount,
      bankName: bankName ?? this.bankName,
      identityId: identityId ?? this.identityId,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      typeName: typeName ?? this.typeName,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      countryName: countryName ?? this.countryName,
      position: position ?? this.position,
      email: email ?? this.email,
      permissionList: permissionList ?? this.permissionList,
      permission: permission ?? this.permission,
      roleId: roleId ?? this.roleId,
      password: password ?? this.password,
      roleName: roleName ?? this.roleName,

    );
  }
  DateTime getBirdDay(){
   return DateTimeHelper.stringToDate(birthday??"" ,currentTypeDate:  DateTimeHelper.yyyyMMDD)??DateTime.now();
  }
}

class UserListResponseModel extends PageModel{
  List<UserProfile>? content;

  UserListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  UserListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <UserProfile>[];
      json['content'].forEach((v) {
        content!.add(new UserProfile.fromJson(v));
      });
    }
  }
  UserListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <UserProfile>[];
      json.forEach((v) {
        content!.add(new UserProfile.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['pageSize'] = pageSize;
    data['pageNumber'] = pageNumber;
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    return data;
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
