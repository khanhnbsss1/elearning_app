import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/components/price_tag.dart';
import 'package:lms_app/mixins/course_mixin.dart';
import 'package:lms_app/mixins/user_mixin.dart';
import 'package:lms_app/screens/test/test_list_screen.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import '../../../models/course.dart';
import '../../../models/user_model.dart';
import '../../../models/user/UserProfile.dart';
import '../../course_details.dart/details_view.dart';
import '../../../utils/custom_cached_image.dart';
import '../../../utils/next_screen.dart';
import '../../test/test_screen.dart';

class MyCourseTile extends StatelessWidget with UserMixin {
  const MyCourseTile({super.key, required this.course, required this.user});

  final CourseInfo course;
  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    final heroTag = UniqueKey();
    String courseProgressString =  '0'; //(courseProgress * 100).toStringAsFixed(0);

    return InkWell(
      onTap: () => NextScreen.iOS(context, CourseDetailsView(courses: course, heroTag: heroTag)),
      // onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container( 
                height: 90,
                width: 100,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
                child: Hero(
                    tag: heroTag,
                    child: (course.image != null && course.image != "")
                        ? CustomCacheImage(
                        imageUrl: course.image, radius: 3)
                        : Image.asset("assets/images/noImage.jpg",
                        fit: BoxFit.cover)),
              ),
              PremiumTag(course: course),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'By ${course.producerName}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blueAccent),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 5),
                    child: LinearProgressIndicator(
                      value: int.parse(courseProgressString) / 100,
                      borderRadius: BorderRadius.circular(20),
                      minHeight: 8,
                      color: Colors.orange.shade300,
                    ),
                  ),
                  const Text('percent-completed').tr(args: [courseProgressString]),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        side: BorderSide(color: Theme.of(context).primaryColor),
                        textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)
                        ),
                    child: Text(CourseMixin.enrollButtonText(course, user), style: TextStyle(color: Theme.of(context).primaryColor),).tr(),
                    onPressed: () => handleOpenCourse(context, user: user, course: course),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        side: BorderSide(color: Theme.of(context).primaryColor),
                        textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)
                    ),
                    child: Text('do-test'.tr(), style: TextStyle(color: Theme.of(context).primaryColor),).tr(),
                    onPressed: () {
                      NextScreen.normal(context, const TestListScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
