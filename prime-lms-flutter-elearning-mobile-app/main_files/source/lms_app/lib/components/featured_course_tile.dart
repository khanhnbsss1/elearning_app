import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/constants/custom_colors.dart';
import 'package:lms_app/helper/navigator_key.dart';
import 'package:lms_app/routes/app_routes.dart';
import 'package:lms_app/screens/auth/login.dart';
import 'package:lms_app/services/app_service.dart';
import '../helper/services/navigation_service.dart';
import '../routes/app_pages.dart';
import '../services/apis/course/course_detail/models/course_detail_model.dart';
import 'rating_bar.dart';
import '../models/course.dart';
import '../screens/course_details.dart/details_view.dart';
import '../utils/next_screen.dart';

class FeaturedCourseTile extends StatelessWidget {
  const FeaturedCourseTile({
    super.key,
    required this.course,
  });

  final CourseInfo course;

  @override
  Widget build(BuildContext context) {
    final heroTag = UniqueKey();
    return InkWell(
      onTap: () => NextScreen.iOS(context, CourseDetailsView(courses: course, heroTag: heroTag)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppService.isDarkMode(context) ? CustomColor.borderDark : CustomColor.border
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: heroTag,
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(3), topRight: Radius.circular(3)),
                        image: (course.image != null && course.image != "")
                            ? DecorationImage(image: CachedNetworkImageProvider(course.image!), fit: BoxFit.cover)
                            : const DecorationImage(image: AssetImage("assets/images/noImage.jpg"), fit: BoxFit.cover),
                      ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Theme.of(context).primaryColor.withOpacity(0.8)),
                        margin: const EdgeInsets.all(20),
                        child: Text(
                          'featured',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                        ).tr()),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name??"-",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'total-lectures',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blueGrey),
                  ).tr(args: [course.totalLectures.toString()]),
                  const SizedBox(height: 3),
                  RatingViewer(rating: (course.ratePoint??0).toDouble()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
