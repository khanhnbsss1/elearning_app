import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/views/course/course_study/course_study_introduction.dart';
import 'package:webkit/views/course/course_study/course_study_study.dart';
import 'package:webkit/views/course/course_study/course_study_test.dart';
import 'package:webkit/views/course/create_edit_course/components/build_tab_bar.dart';
import 'package:webkit/views/video_player/model/video_model.dart';
import 'package:webkit/views/video_player/video_player.dart';
import '../../../helpers/utils/ui_mixins.dart';
import '../../../services/apis/course/course_detail/models/course_detail_model.dart';

class CourseStudy extends StatefulWidget {
  final CourseInfo courseInfo;

  const CourseStudy({
    super.key,
    required this.courseInfo,
  });

  void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => this,
    );
  }

  @override
  State<CourseStudy> createState() => _CourseStudyState();
}

class _CourseStudyState extends State<CourseStudy>
    with SingleTickerProviderStateMixin, UIMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(S.of(context).lets_study),
        centerTitle: true,
      ),
      body: BuildTabBar(
        widgets: [
          CourseStudyIntroduction(
            courseInfo: widget.courseInfo,
          ),
          CourseStudyStudy(courseInfo: widget.courseInfo),
          CourseStudyTest(courseInfo: widget.courseInfo),
        ],
        titles: ['Introduction', 'Study', 'Test'],
      ),
    );
  }

  Widget buildVideo() {
    return SizedBox(
      height: 450,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          // child: Image.network(
          //   widget.courseInfo.image!.isNotEmpty
          //       ? widget.courseInfo.image!
          //       : 'assets/deshboard/adventure/adventure5.png',
          //   fit: BoxFit.cover,
          // )
          child: VideoPlayer(
            videoPlayerModel: VideoPlayerModel(
                title: "", link: widget.courseInfo.videoPreview ?? ""),
          ),
        ),
      ),
    );
  }
}
