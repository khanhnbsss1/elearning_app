import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lms_app/base/author/user_helper.dart';
import 'package:lms_app/base/widgets/toast_common/toast_utils.dart';
import 'package:lms_app/mixins/user_mixin.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/screens/auth/login.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/services/apis/rating/models/rating_info.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:lms_app/utils/snackbars.dart';
import '../../models/user/UserProfile.dart';
import '../reviews/rating_form.dart';
import '../../models/review.dart';
import '../../models/user_model.dart';
import '../../providers/user_data_provider.dart';
import '../../services/api_service.dart';

class ReviewButton extends ConsumerWidget with UserMixin {
  const ReviewButton({super.key, required this.contexts, required this.courseDetail, required this.myCourses});
  final BuildContext contexts;
  final CourseInfo courseDetail;
  final List<CourseInfo> myCourses;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserProfile? user = ref.watch(userDataProvider);
    return IconButton(
      tooltip: 'Rate this course',
      onPressed: () async {
        final UserProfile? user = ref.read(userDataProvider);
        if (user == null) {
          NextScreen.openBottomSheet(context, const LoginScreen(popUpScreen: true));
        } else if (!UserManager().checkRegisteredCourse(courseDetail, myCourses)) {
          ToastUtils.showSnackBar(contexts,'enroll-to-make-reviews'.tr());
        } else {
          // final Review? review = await ApiService().getUserReview(courseDetail.id.toString(), user.id.toString());
          // if (!context.mounted) return;
          NextScreen.openBottomSheet(context, RatingForm(courseDetail: courseDetail,));
        }
      },
      icon: const Icon(Icons.comment_outlined, size: 22, color: Colors.white,),
    );
  }
}
