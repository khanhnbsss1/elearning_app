import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/base/author/user_helper.dart';
import 'package:lms_app/base/widgets/my_button.dart';
import 'package:lms_app/models/user/UserProfile.dart';
import 'package:lms_app/screens/course_details.dart/register_button.dart';
import 'package:lms_app/screens/reviews/rating_form.dart';
import 'package:lms_app/constants/custom_colors.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/theme/theme_provider.dart';
import '../../base/widgets/toast_common/toast_utils.dart';
import '../../components/rating_bar.dart';
import '../../helper/services/navigation_service.dart';
import '../../services/apis/course/register_course/register_course.dart';
import '../curricullam_screen.dart';
import '../tabs/my_courses_tab/my_courses_tab.dart';

class TitleInfo extends ConsumerWidget {
  const TitleInfo({super.key, required this.course});

  final CourseInfo course;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool check = false;
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    final rating = ref.watch(courseRatingProvider(course));
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        course.name ?? "-",
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 24,
              height: 1.5,
              wordSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              RatingViewer(rating: rating),
            ],
          ),
          const SizedBox(width: 20),
          Text(
            'total-lectures',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ).tr(args: [course.totalLectures.toString()]),
        ],
      ),
      const SizedBox(
        height: 8,
      ),
      // Center(
      //   child: Column(
      //     children: [
      //       Text(
      //         '${course.originalPrice ?? 0} VND',
      //         style: const TextStyle(
      //             decoration: TextDecoration.lineThrough,
      //             color: Colors.black45,
      //             fontSize: 14,
      //             fontWeight: FontWeight.w400),
      //       ),
      //       const SizedBox(
      //         height: 8,
      //       ),
      //       Text(
      //         '${course.payment} VND',
      //         style: const TextStyle(
      //             decoration: TextDecoration.underline,
      //             decorationColor: Color(0xFFFFC711),
      //             fontStyle: FontStyle.italic,
      //             color: Color(0xFFFFC711),
      //             fontSize: 18,
      //             fontWeight: FontWeight.bold),
      //       ),
      //       const SizedBox(
      //         height: 8,
      //       ),
      //     ],
      //   ),
      // ),
    ]);
  }
}
