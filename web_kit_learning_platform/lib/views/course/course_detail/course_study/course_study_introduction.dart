import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webkit/views/course/course_detail/bloc/course_detail_bloc.dart';
import 'package:webkit/views/course/course_detail/components/course_intro.dart';

import '../../../video_player/model/video_model.dart';
import '../../../video_player/video_player.dart';

class CourseStudyIntroduction extends StatefulWidget {
  const CourseStudyIntroduction({
    super.key,
  });

  @override
  State<CourseStudyIntroduction> createState() => _CourseStudyIntroductionState();
}

class _CourseStudyIntroductionState extends State<CourseStudyIntroduction> {
  late CourseDetailState _state;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseDetailBloc, CourseDetailState>(
      buildWhen: (previous, current) {
        return current.blocStatus != AddCourseStatus.onChangeRating && current.blocStatus != AddCourseStatus.getRatingList && current.blocStatus != AddCourseStatus.onSubmitRating;
      },
      listener: (context, state) {
        switch (state.blocStatus) {
          case AddCourseStatus.initial:
            break;
          default:
            break;
        }
      },
      builder: (BuildContext context, state) {
        _state = state;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: buildInfoBox(),
          ),
        );
      },
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
            buildVideo(state: _state),
            CourseIntro(),
          ],
        ),
      ),
    );
  }

  Widget buildVideo({required CourseDetailState state}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 450,
      child: VideoPlayer(
        videoPlayerModel: VideoPlayerModel(
          title: "",
          link:
          // "https://www.youtube.com/watch?v=jxAljZD0B7Q&list=PL7K6oq4k49igroleELfyc8BCoZAkgjDmZ&index=4"
          state.courseInfo?.videoPreview ?? "",
        ),
      ),
    );
  }
}
