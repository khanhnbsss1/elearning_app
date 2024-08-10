
import 'UserProfile.dart';


class RecentUserList {
  List<UserProfile>? recentUserContentList;

  RecentUserList({this.recentUserContentList}){
    recentUserContentList??=[];
  }

  RecentUserList.fromJson(Map<String, dynamic> json) {
    recentUserContentList = <UserProfile>[];
    if (json['RecentUser'] != null) {
      json['RecentUser'].forEach((v) {
        recentUserContentList!.add(UserProfile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recentUserContentList != null) {
      data['RecentUser'] = recentUserContentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

