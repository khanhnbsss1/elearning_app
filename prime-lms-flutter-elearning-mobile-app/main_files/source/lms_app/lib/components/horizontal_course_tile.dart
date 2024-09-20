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
    required this.isDarkMode,
  });
  final bool isDarkMode;
  final CourseInfo course;
  final double widthPercentage;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    final heroTag = UniqueKey();

    return GestureDetector(
      onTap: () => NextScreen.iOS(
          context, CourseDetailsView(courses: course, heroTag: heroTag)),
      child: Container(
        decoration: BoxDecoration(
          color: (isDarkMode != true) ? Colors.white : Colors.black.withOpacity(0.1),
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10)
        ),
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
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)),
                        child: (course.image != null && course.image != "")
                            ? CustomCacheImage(
                          imageUrl: course.image,
                          radius: 12,
                        )
                            : Image.asset(
                          "assets/images/noImage1.jpg",
                          fit: BoxFit.cover,
                        ),
                      )
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
                    '${course.name!} \n',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600,
                        // color: (isDarkMode != true) ? Colors.black : Colors.white),
                        color: Colors.black,
                    ),
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
