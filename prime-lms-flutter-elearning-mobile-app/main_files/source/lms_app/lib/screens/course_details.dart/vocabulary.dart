import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lms_app/ads/ad_manager.dart';
import 'package:lms_app/constants/app_constants.dart';
import 'package:lms_app/mixins/course_mixin.dart';
import 'package:lms_app/mixins/user_mixin.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/models/user_model.dart';
import 'package:lms_app/screens/article_lesson.dart';
import 'package:lms_app/screens/auth/login.dart';
import 'package:lms_app/screens/quiz_lesson/quiz_screen.dart';
import 'package:lms_app/screens/video_lesson.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/services/apis/lessson/models/lesson_info.dart';
import 'package:lms_app/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:lms_app/utils/loading_widget.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:lms_app/utils/snackbars.dart';

import '../../models/lesson.dart';
import '../../models/user/UserProfile.dart';
import '../../providers/user_data_provider.dart';

class Vocabulary extends ConsumerWidget with CourseMixin, UserMixin {
  const Vocabulary({super.key, required this.course, required this.sectionId});

  final CourseInfo course;
  final int sectionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          '${course.name} - ${course.lectures![sectionId].lectureName}',
          maxLines: 2,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600, color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Column(
          children: [
            (course.lectures![sectionId].vocabularies != null) ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 0, bottom: 20),
              itemCount: course.lectures![sectionId].vocabularies!.length,
              itemBuilder: (context, index) {
                final VocabularyInfo word = course.lectures![sectionId].vocabularies![index];
                return ListTile(
      
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  horizontalTitleGap: 10,
                  title: Text(
                    word.simplified!,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  subtitle: Text(word.traditional!).tr(),
                  leading: Text(
                    '${index + 1}.',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.blue),
                  ),);
              },
            ) : const SizedBox(),
      
          ]
      ),
    );
  }
}
