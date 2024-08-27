import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/services/apis/tags/models/tag_info.dart';

import '../../../models/tag.dart';
import '../../all_courses.dart/courses_view.dart';
import '../../../utils/next_screen.dart';

class PopularTags extends StatelessWidget {
  const PopularTags({super.key, required this.tags});

  final List<TagsInfo> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 3,
      children: tags.map((tag) {
        return ActionChip(
          // onPressed: () => NextScreen.iOS(
          //   context,
          //   AllCoursesView(title: '#${tag.name}', tagId: tag.id),
          // ),
          onPressed: (){},
          label: Text(
            tag.name!,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        );
      }).toList(),
    );
  }
}