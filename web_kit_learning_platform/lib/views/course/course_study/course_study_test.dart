import 'package:flutter/cupertino.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';

class CourseStudyTest extends StatefulWidget {
  final CourseInfo courseInfo;

  const CourseStudyTest({super.key, required this.courseInfo});

  @override
  State<CourseStudyTest> createState() => _CourseStudyTestState();
}

class _CourseStudyTestState extends State<CourseStudyTest> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
