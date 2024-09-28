import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/models/user_model.dart';
import 'package:lms_app/screens/author_profie/author_profile.dart';
import 'package:lms_app/services/app_service.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:lms_app/utils/snackbars.dart';

import '../../constants/custom_colors.dart';
import '../../models/user/UserProfile.dart';

class CourseInfoScreen extends StatelessWidget {
  const CourseInfoScreen({super.key, required this.course});
  final CourseInfo course;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course.introduction.toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 17,
              // color: isDarkMode
              //     ? CustomColor.paragraphColorDark
              color: CustomColor.paragraphColor,
              height: 1.7,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              text: 'created-by'.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              children: [
                const TextSpan(text: ' '),
                TextSpan(
                  text: course.producerName,
                  // recognizer: TapGestureRecognizer()..onTap = () => _onTapAuthor(context),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.blue),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Row(
          //   children: [
          //     const Icon(FeatherIcons.calendar, size: 20, color: Colors.blueGrey),
          //     const SizedBox(width: 5),
          //     Text('last-updated-', style: Theme.of(context).textTheme.bodyLarge).tr(
          //       args: [AppService.getDate((course.updatedAt ?? course.createdAt) as DateTime)],
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 8),
          Row(
            children: [
              const Icon(FeatherIcons.globe, size: 20, color: Colors.blueGrey),
              const SizedBox(width: 5),
              Text('language-', style: Theme.of(context).textTheme.bodyLarge).tr(args: [course.language.toString()]),
              // Text('language', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(FeatherIcons.clock, size: 20, color: Colors.blueGrey),
              const SizedBox(width: 5),
              // Text('duration-', style: Theme.of(context).textTheme.bodyLarge).tr(args: [course.courseMeta.duration.toString()]),
              Text('duration-', style: Theme.of(context).textTheme.bodyLarge).tr(args: [course.durian??""]),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(FeatherIcons.book, size: 20, color: Colors.blueGrey),
              const SizedBox(width: 5),
              // Text('count-lesson', style: Theme.of(context).textTheme.bodyLarge).tr(args: [course.lessonsCount.toString()]),
              Text('count-lesson', style: Theme.of(context).textTheme.bodyLarge).tr(args: [course.totalLectures.toString()]),
            ],
          ),
        ],
      ),
    );
  }

  // void _onTapAuthor(BuildContext context) async {
  //   final UserProfile? author = await FirebaseService().getAuthorData(course.author.id);
  //   if (!context.mounted) return;
  //   if (author != null) {
  //     NextScreen.popup(context, AuthorProfile(user: author));
  //   } else {
  //     openSnackbar(context, 'Error on getting author profile');
  //   }
  // }
}
