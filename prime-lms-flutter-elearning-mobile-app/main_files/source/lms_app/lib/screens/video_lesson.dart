import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/screens/video_player_screen.dart';
import 'package:lms_app/services/apis/lessson/models/lesson_info.dart';
import 'package:lms_app/services/content_security_service.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import '../components/mark_complete_button.dart';
import '../models/course.dart';
import '../models/lesson.dart';

class VideoLesson extends ConsumerStatefulWidget {
  const VideoLesson({super.key, required this.course, required this.lesson});

  final CourseInfo course;
  final LessonInfo lesson;

  @override
  ConsumerState<VideoLesson> createState() => _VideoLessonState();
}

class _VideoLessonState extends ConsumerState<VideoLesson> {
  @override
  void initState() {
    ContentSecurityService().initContentSecurity(ref);
    super.initState();
  }

  @override
  void dispose() {
    ContentSecurityService().disposeContentSecurity();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          VideoPlayerScreen(link: widget.lesson.link.toString()),
          Align(
            alignment: Alignment.bottomCenter,
            child: FutureBuilder(
              future: Future.delayed(const Duration(seconds: 2)),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return const SizedBox();
                  // return MarkCompleteButton(course: widget.course, lesson: widget.lesson);
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
