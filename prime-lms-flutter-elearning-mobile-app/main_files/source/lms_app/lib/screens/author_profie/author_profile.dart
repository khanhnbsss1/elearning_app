import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/constants/custom_colors.dart';
import 'package:lms_app/models/user_model.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/services/apis/teacher_list/models/synthesisInfo.dart';
import 'package:lms_app/services/apis/teacher_list/teacher_list/get_data_synthesis_api.dart';
import '../../models/user/UserProfile.dart';
import '../../services/apis/teacher_list/models/landing_page_teacher_list_model.dart';
import '../../services/apis/teacher_list/models/teacher_model.dart';
import '../../theme/theme_provider.dart';
import 'author_courses.dart';
import 'count_info.dart';
import 'profile_info.dart';

final authorReviewsCountProvider = FutureProvider.family.autoDispose<int, String>((ref, authorId) async {
  final int count = await ApiService().getAuthorReviewsCount(authorId);
  return count;
});

final authorCoursesCountProvider = FutureProvider.family.autoDispose<int, String>((ref, authorId) async {
  final int count = await ApiService().getAuthorCourseCount(authorId);
  return count;
});

class AuthorProfile extends ConsumerWidget {
  const AuthorProfile({super.key, required this.teacherDetail});

  final TeacherDetail teacherDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider).isDarkMode;

    // final String jobTitle = user.authorInfo?.jobTitle ?? '';
    // final String bio = user.authorInfo?.bio ?? '';
    // final int students = user.authorInfo?.students ?? 0;
    // final int reviewsCount = ref.watch(authorReviewsCountProvider(user.id.toString())).value ?? 0;
    // final int courseCount = ref.watch(authorCoursesCountProvider(user.id.toString())).value ?? 0;

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text('instructor').tr(),
            foregroundColor: Colors.white,
            pinned: false,
            floating: true,
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                AuthorProfileInfo(teacherDetail: teacherDetail,),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthorCountInfo(students: teacherDetail.totalStudent??20, courseCount: teacherDetail.totalCourse??2, reviewsCount: teacherDetail.totalReview??20,),
                      const SizedBox(height: 40),
                      Text(
                        'about-me',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ).tr(),
                      const SizedBox(height: 10),
                      Text(
                        teacherDetail.bio??"",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.7,
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: isDarkMode ? CustomColor.paragraphColorDark : CustomColor.paragraphColor,
                            ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'my-courses',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ).tr(),
                      const SizedBox(height: 10),
                      AuthorCourses(
                        teacherDetail: teacherDetail,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Future<void> getData() async{
  //   GetDataSynthesisApi getDataSynthesisApi = GetDataSynthesisApi();
  //   SynthesisSummaryInfo synthesisSummaryInfo = await getDataSynthesisApi.call();
  //   synthesisSummaryInfo;
  //   return;
  // }
}
