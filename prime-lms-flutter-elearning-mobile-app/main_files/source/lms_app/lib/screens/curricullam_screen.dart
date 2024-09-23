import 'package:flutter/material.dart';
import 'package:lms_app/screens/course_details.dart/sections.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/utils/empty_animation.dart';

import '../configs/app_assets.dart';
import '../utils/loading_widget.dart';

class CurriculamStudy extends StatefulWidget {
  const CurriculamStudy({super.key, required this.courseDetail});

  final CourseInfo courseDetail;

  @override
  State<CurriculamStudy> createState() => _CurriculamStudyState();
}

class _CurriculamStudyState extends State<CurriculamStudy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: false,
          titleSpacing: 0,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          title: Text(
            widget.courseDetail.name ?? "-",
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Sections(
                courseDetail: widget.courseDetail,
                isInitialSectionOpen: false,
                enabled: true,
              )
            ],
          ),
        ));
  }
}
