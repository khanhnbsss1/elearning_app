import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/ads/ad_manager.dart';
import 'package:lms_app/iAP/iap_config.dart';
import 'package:lms_app/models/app_settings_model.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/models/user_model.dart';
import 'package:lms_app/providers/app_settings_provider.dart';
import 'package:lms_app/screens/curricullam_screen.dart';
import 'package:lms_app/screens/home/home_bottom_bar.dart';
import 'package:lms_app/screens/home/home_view.dart';
import 'package:lms_app/screens/intro.dart';
import 'package:lms_app/screens/auth/login.dart';
import 'package:lms_app/services/auth_service.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:lms_app/utils/snackbars.dart';
import '../iAP/iap_screen.dart';
import '../models/user/UserProfile.dart';
import '../providers/user_data_provider.dart';
import '../services/apis/course/course_detail/models/course_detail_model.dart';

mixin UserMixin {
  void handleLogout(context, {required WidgetRef ref}) async {
    await AuthService().userLogOut().onError((error, stackTrace) => debugPrint('error: $error'));
    await AuthService().googleLogout().onError((error, stackTrace) => debugPrint('error1: $error'));
    ref.invalidate(userDataProvider);
    ref.invalidate(homeTabControllerProvider);
    ref.invalidate(navBarIndexProvider);
    NextScreen.closeOthersAnimation(context, const LoginScreen());
  }

  bool hasEnrolled(UserProfile? user, CourseInfo course) {
    if (user != null && user.enrolledCourses != null && user.enrolledCourses!.contains(course.id)) {
      return true;
    } else {
      return false;
    }
  }

  static bool isExpired(UserProfile user) {
    final DateTime expireDate = user.subscription!.expireAt;
    final DateTime now = DateTime.now().toUtc();
    final difference = expireDate.difference(now).inDays;
    if (difference >= 0) {
      return false;
    } else {
      return true;
    }
  }

  static bool isUserPremium(UserProfile? user) {
    return user != null && user.subscription != null && isExpired(user) == false ? true : false;
  }

  int remainingDays(UserProfile user) {
    final DateTime expireDate = user.subscription!.expireAt;
    final DateTime now = DateTime.now().toUtc();
    final difference = expireDate.difference(now).inDays;
    return difference;
  }

  Future handleEnrollment(
    BuildContext context, {
    required UserProfile? user,
    required CourseInfo course,
    required WidgetRef ref,
  }) async {
    if (user != null) {
      if (course.mode == 'FREE') {
        // Free Course
        if (hasEnrolled(user, course)) {
          NextScreen.popup(context, CurriculamScreen(courseDetail: course));
        } else {
          AdManager.initInterstitailAds(ref);
          await _comfirmEnrollment(context, user, course, ref);
        }
      } else {
        //  Premium Course
        if (user.subscription != null && !isExpired(user)) {
          if (hasEnrolled(user, course)) {
            NextScreen.popup(context, CurriculamScreen(courseDetail: course));
          } else {
            await _comfirmEnrollment(context, user, course, ref);
          }
        } else {
          // Checking license before opening iAP
          final settings = ref.read(appSettingsProvider);
          if (IAPConfig.iAPEnabled && settings?.license == LicenseType.extended) {
            NextScreen.openBottomSheet(context, const IAPScreen(), isDismissable: false);
          } else {
            openSnackbarFailure(context, 'Extended license required!');
          }
        }
      }
    } else {
      NextScreen.openBottomSheet(context, const LoginScreen(popUpScreen: true));
    }
  }

  Future _comfirmEnrollment(BuildContext context, UserProfile user, CourseInfo course, WidgetRef ref) async {
    // await FirebaseService().updateEnrollment(user, course);
    // await FirebaseService().updateStudentCountsOnCourse(true, course.id);
    // await FirebaseService().updateStudentCountsOnAuthor(true, course.author.id);
    await ref.read(userDataProvider.notifier).getData();
    if (!context.mounted) return;
    openSnackbar(context, 'Enrolled Succesfully');
  }

  Future handleOpenCourse(
    BuildContext context, {
    required UserProfile user,
    required CourseInfo courseDetail,
  }) async {
    if (courseDetail.mode == 'FREE') {
      NextScreen.popup(context, CurriculamScreen(courseDetail: courseDetail));
    } else {
      if (true) {
        NextScreen.popup(context, CurriculamScreen(courseDetail: courseDetail));
      }
      // else {
      //   NextScreen.openBottomSheet(context, const IAPScreen());
      // }
    }
  }
}
