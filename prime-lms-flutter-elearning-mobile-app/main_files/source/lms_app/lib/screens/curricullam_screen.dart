import 'package:flutter/material.dart';
import 'package:lms_app/screens/course_details.dart/sections.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/utils/empty_animation.dart';

import '../configs/app_assets.dart';
import '../utils/loading_widget.dart';

class CurriculamScreen extends StatefulWidget {
  const CurriculamScreen({super.key, required this.course});

  final CourseInfo course;

  @override
  State<CurriculamScreen> createState() => _CurriculamScreenState();
}

class _CurriculamScreenState extends State<CurriculamScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCourseDetail(widget.course),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Scaffold(
                appBar: AppBar(
                  toolbarHeight: 80,
                  centerTitle: false,
                  titleSpacing: 0,
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  title: Text(
                    "-",
                    maxLines: 2,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  elevation: 0,
                ),
                body: const Center(
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: LoadingIndicatorWidget())));
          } else if (snapshot.hasError) {
            return const EmptyAnimation(animationString: emptyAnimation, title: "No lecture found");
          } else {
            CourseInfo courseDetail = snapshot.data!;
            return Scaffold(
                appBar: AppBar(
                  toolbarHeight: 80,
                  centerTitle: false,
                  titleSpacing: 0,
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  title: Text(
                    courseDetail.name ?? "-",
                    maxLines: 2,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Sections(
                        course: courseDetail,
                        isInitialSectionOpen: false,
                      )
                    ],
                  ),
                ));
          }

        });
  }

  Future<CourseInfo> getCourseDetail(CourseInfo courseInfo) async {
    CourseInfo courseDetail =
        await ApiService().getCourseDetail(course: courseInfo);
    return courseDetail;
  }
}
