import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

import '../../models/course.dart';
import '../../services/apis/course/course_detail/models/course_detail_model.dart';

class Requirements extends StatelessWidget {
  const Requirements({
    super.key,
    required this.course,
  });

  final CourseInfo course;

  @override
  Widget build(BuildContext context) {
    List<String> courseObj = (course.infoObj??"").split("&&&");
    return Visibility(
      visible: course.infoObj != null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'requirements',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ).tr(),
            const SizedBox(
              height: 5,
            ),
            Column(
              children: courseObj
                  .map((e) => ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        horizontalTitleGap: 10,
                        title: Text(e),
                        leading: const Icon(FeatherIcons.check, color: Colors.blueAccent),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
