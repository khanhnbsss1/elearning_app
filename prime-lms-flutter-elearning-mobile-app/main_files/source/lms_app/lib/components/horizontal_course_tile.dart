import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lms_app/components/price_tag.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'rating_bar.dart';
import '../screens/course_details.dart/details_view.dart';
import '../utils/custom_cached_image.dart';
import '../utils/next_screen.dart';

class HorizontalCourseTile extends StatelessWidget {
  const HorizontalCourseTile({
    super.key,
    required this.course,
    required this.widthPercentage,
    required this.imageHeight,
  });

  final CourseInfo course;
  final double widthPercentage;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    final heroTag = UniqueKey();
    return InkWell(
      onTap: () => NextScreen.iOS(
          context, CourseDetailsView(courses: course, heroTag: heroTag)),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * widthPercentage,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                    height: imageHeight,
                    width: MediaQuery.of(context).size.width,
                    child: Hero(
                      tag: heroTag,
                      child: (course.image != null && course.image != "")
                          ? CustomCacheImage(
                              imageUrl: course.image,
                              radius: 0,
                            )
                          : Image.asset(
                              "assets/images/noImage.jpg",
                              fit: BoxFit.cover,
                            ),
                    )),
                // PremiumTag(course: course),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 3),
                  RatingViewer(rating: (course.ratePoint ?? 0).toDouble()),
                  const SizedBox(height: 3),
                  Text(
                    'total-lectures',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.blueGrey),
                  ).tr(args: [course.totalLectures.toString()])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
