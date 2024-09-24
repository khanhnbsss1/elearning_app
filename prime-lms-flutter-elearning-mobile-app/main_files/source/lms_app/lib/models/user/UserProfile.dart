
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lms_app/models/author_info.dart';
import 'package:lms_app/models/subscription.dart';

import '../../base/base_request_elearning/models/page_model.dart';

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
  List<String>? permissionList;
  String? permission;
  int? roleId;
  String? roleName;
  int? isPayment;
  int? fileId;
  String? accountId;
  String? website;
  String? facebook;
  String? twitter;
  String? youtube;

  String? imageUrl;
  List? role;
  List? enrolledCourses;
  List? wishList;
  bool? isDisabled;
  AuthorInfo? authorInfo;
  Subscription? subscription;
  List? completedLessons;
  String? platform;
  List? reviews;

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
        this.imageUrl,
        this.role,
        this.accountId,
        this.enrolledCourses,
        this.wishList,
        this.isDisabled,
        this.authorInfo,
        this.subscription,
        this.completedLessons,
        this.platform,
        this.reviews,
        this.isPayment,
        this.fileId,
        this.roleName,
        this.website,
        this.facebook,
        this.youtube,
        this.twitter
      });

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    fullName = json['fullName'];
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
    permission=json['permissions']??'';
    permissionList = [];
    if(permission!=null && (permission??'').isNotEmpty)
    {
      permissionList = (json['permissions'] as String).split(',');
    }
    roleId = json['role_id'];
    roleName = json['roleName'];
    imageUrl = json['imageUrl'];
    role = json['role'];
    accountId = json['account_id'];
    enrolledCourses = json['enrolledCourses'];
    wishList = json['wishList'] ?? [];
    isDisabled = json['isDisabled'];
    authorInfo = json['authorInfo'] = null;
        // ? AuthorInfo.fromJson(json['authorInfo']) : null;
    subscription = json['subscription'] = null ;
        // ? Subscription.fromJson(json['subscription']) : null;
    completedLessons = json['completedLessons'];
    platform = json['platform'];
    reviews = json['reviews'];
    isPayment = json['is_payment'];
    fileId = json['file_id'];
    website = json['website'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    youtube = json['youtube'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName??"";
    data['user_name'] = userName??"";
    data['bank_account'] = bankAccount??"";
    data['bank_name'] = bankName??"";
    data['identity_id'] = identityId;
    data['gender'] = gender??"";
    data['birthday'] = birthday??"";
    data['phone_number'] = phoneNumber??"";
    data['avatar'] = avatar??"";
    data['type_name'] = typeName??"web";
    data['created_at'] = createdAt??"";
    data['created_by'] = createdBy??"";
    data['updated_at'] = updatedAt??"";
    data['updated_by'] = updatedBy??"";
    data['country_name'] = countryName??"";
    data['position'] = position??"";
    data['email'] = email??"";
    data['permissions'] = permission;
    data['role_id'] = roleId;
    data['account_id'] = accountId;
    data['imageUrl'] = imageUrl;
    data['role'] = role;
    data['enrolledCourses'] = enrolledCourses;
    data['wishList'] = wishList;
    data['isDisabled'] = isDisabled;
    // data['authorInfo'] = authorInfo?.toJson();
    data['authorInfo'] = null;
    // data['subscription'] = subscription?.toJson();
    data['subscription'] = null;
    data['roleName'] = roleName;
    data['completedLessons'] = completedLessons;
    data['platform'] = platform;
    data['reviews'] = reviews;
    data['isPayment'] = isPayment;
    data['file_id'] = fileId;
    data['website'] = website;
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['youtube'] = youtube;
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
    String? imageUrl,
    String? roleName,
    List? role,
    List? enrolledCourses,
    List? wishList,
    bool? isDisabled,
    AuthorInfo? authorInfo,
    Subscription? subscription,
    List? completedLessons,
    String? platform,
    String? accountId,
    List? reviews,
    int? isPayment,
    int? fileId,
    String? facebook,
    String? website,
    String? youtube,
    String? twitter,
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
      imageUrl: imageUrl ?? this.imageUrl,
      role: role ?? this.role,
      roleName: roleName ?? this.roleName,
      accountId: accountId ?? this.accountId,
      enrolledCourses: enrolledCourses ?? this.enrolledCourses,
      wishList: wishList ?? this.wishList,
      isDisabled: isDisabled ?? this.isDisabled,
      authorInfo: authorInfo ?? this.authorInfo,
      subscription: subscription ?? this.subscription,
      completedLessons: completedLessons ?? this.completedLessons,
      platform: platform ?? this.platform,
      reviews: reviews ?? this.reviews,
      isPayment: isPayment ?? this.isPayment,
      fileId: fileId ?? this.fileId,
      facebook: facebook?? this.facebook,
      website: website ?? this.website,
      youtube: youtube ?? this.youtube,
      twitter: twitter ?? this.twitter,
    );
  }

  factory UserProfile.fromFirebase(DocumentSnapshot snap) {
    Map d = snap.data() as Map<String, dynamic>;
    return UserProfile(
      id: d['id'],
      email: d['email'],
      imageUrl: d['image_url'],
      role: d['role'] ?? [],
      authorInfo: d['author_info'] == null ? null : AuthorInfo.fromMap(d['author_info']),
      enrolledCourses: d['enrolled'] ?? [],
      wishList: d['wishlist'] ?? [],
      subscription: d['subscription'] == null ? null : Subscription.fromFirestore(d['subscription']),
      completedLessons: d['completed_lessons'] ?? [],
      platform: d['platform'],
      reviews: d['reviews'] ?? [],
    );
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
