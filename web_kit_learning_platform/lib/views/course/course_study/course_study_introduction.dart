import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/views/course/course_detail/components/course_intro.dart';

import '../../../base/widgets/button/action_button1.dart';
import '../../video_player/model/video_model.dart';
import '../../video_player/video_player.dart';

class CourseStudyIntroduction extends StatefulWidget {
  final CourseInfo courseInfo;

  const CourseStudyIntroduction({super.key, required this.courseInfo});

  @override
  State<CourseStudyIntroduction> createState() =>
      _CourseStudyIntroductionState();
}

class _CourseStudyIntroductionState extends State<CourseStudyIntroduction> {
  late List<String> courseObject = widget.courseInfo.infoObj?.split("&&&").map((e) => e.trim()).toList() ?? [];

  late List<String> courseResult = widget.courseInfo.infoResult?.split("&&&").map((e) => e.trim()).toList() ?? [];
  @override
  void initState() {
    super.initState();
  }
  //
  // courseObject = widget.courseInfo.infoObj?.split("&&&").map((e) => e.trim()).toList() ?? [];
  // courseResult = widget.courseInfo.infoResult?.split("&&&").map((e) => e.trim()).toList() ?? [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: buildInfoBox(),
      ),
    );
  }

  Widget buildInfoBox() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildVideo(),
            CourseIntro(),
          ],
        ),
      ),
    );
  }

  Widget buildVideo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 450,
      child: VideoPlayer(
        videoPlayerModel: VideoPlayerModel(
            title: "",
            link:
            "https://www.youtube.com/watch?v=jxAljZD0B7Q&list=PL7K6oq4k49igroleELfyc8BCoZAkgjDmZ&index=4" //widget.courseInfo.videoPreview ?? ""
        ),
      ),
    );
  }
}
