import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/base/author/user_helper.dart';
import '../models/user_model.dart';
import '../models/user/UserProfile.dart';
import '../services/firebase_service.dart';

final userDataProvider = StateNotifierProvider<UserData, UserProfile?>((ref) {
  return UserData();
});

class UserData extends StateNotifier<UserProfile?> {
  UserData() : super(null);

  Future getData() async {
    state = await UserManager().getUserProfile();
    debugPrint('Got User Data');
  }
}