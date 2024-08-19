import 'package:flutter/material.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/services_elearning/apis/course/course_detail/models/course_detail_model.dart';

import '../configs/app_assets.dart';
import '../constants/app_constants.dart';

class PremiumTag extends StatelessWidget {
  const PremiumTag({super.key, required this.course});

  final CourseInfo course;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: course.mode == "PREMIUM",
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: Image.asset(premiumImage, height: 16, width: 16, fit: BoxFit.contain)),
      ),
    );
  }
}
