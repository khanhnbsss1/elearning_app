import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/components/html_body.dart';
import 'package:lms_app/models/course.dart';

import '../../services/apis/course/course_detail/models/course_detail_model.dart';

class CourseDescription extends StatelessWidget {
  const CourseDescription({super.key, required this.course});

  final CourseInfo course;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: course.introduction != null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'course-details',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ).tr(),
            const SizedBox(
              height: 10,
            ),
            Text(course.introduction!)
          ],
        ),
      ),
    );
  }
}
