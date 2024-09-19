import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/utils/cache_image_filter.dart';
import 'package:pod_player/pod_player.dart';
import '../../components/video_player.dart';
import '../../models/course.dart';
import '../../services/app_service.dart';
import '../../utils/custom_cached_image.dart';
import '../../utils/next_screen.dart';
import '../video_player_screen.dart';

class PreviewBox extends StatefulWidget {
  const PreviewBox({
    super.key,
    required this.course,
    required this.heroTag,
  });

  final CourseInfo course;
  final Object? heroTag;

  @override
  State<PreviewBox> createState() => _PreviewBoxState();
}

class _PreviewBoxState extends State<PreviewBox> {
  late final PodPlayerController controller;
  late String video;

  @override
  void initState() {
    super.initState();
    video = widget.course.videoPreview ?? "https://youtu.be/pAIH_um52ZA";
    final String videoType = AppService.getVideoType(video);
    controller = PodPlayerController(
        playVideoFrom: videoType == 'network'
            ? PlayVideoFrom.network(video)
            : videoType == 'vimeo'
                ? PlayVideoFrom.vimeo(video)
                : PlayVideoFrom.youtube(video),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: false,
          isLooping: false,
        ))
      ..initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PodVideoPlayer(
          controller: controller,
          alwaysShowProgressBar: true,
          videoThumbnail: null,
        ),
        // Visibility(
        //   visible: hasVideoPreview,
        //   child: const Align(
        //     alignment: Alignment.center,
        //     child: IgnorePointer(
        //       child: Icon(
        //         CupertinoIcons.play,
        //         size: 45,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
