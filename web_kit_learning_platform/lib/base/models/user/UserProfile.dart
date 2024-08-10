
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
        this.email});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullname'];
    userName = json['user_name'];
    bankAccount = json['bank_account'];
    bankName = json['bank_name'];
    identityId = json['identity_id'];
    gender = json['gender'];
    birthday = json['birthday'];
    phoneNumber = json['phone_number'];
    avatar = json['avatar'];
    typeName = json['type_name'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    countryName = json['country_name'];
    position = json['position'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullName;
    data['user_name'] = userName;
    data['bank_account'] = bankAccount;
    data['bank_name'] = bankName;
    data['identity_id'] = identityId;
    data['gender'] = gender;
    data['birthday'] = birthday;
    data['phone_number'] = phoneNumber;
    data['avatar'] = avatar;
    data['type_name'] = typeName;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['updated_at'] = updatedAt;
    data['updated_by'] = updatedBy;
    data['country_name'] = countryName;
    data['position'] = position;
    data['email'] = email;
    return data;
  }
  String getPermission(){
    return "";
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
    );
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
