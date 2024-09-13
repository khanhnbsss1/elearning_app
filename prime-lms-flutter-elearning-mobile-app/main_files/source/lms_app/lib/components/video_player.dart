import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lms_app/services/app_service.dart';
import 'package:pod_player/pod_player.dart';

import '../services/apis/lessson/lesson_detail/update_study_lesson_proccess.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    super.key,
    required this.videoUrl,
    required this.videoTitle,
    this.thumbnailUrl,
    required this.courseId,
    required this.lectureId,
  });

  final String videoTitle;
  final String videoUrl;
  final String? thumbnailUrl;
  final int courseId;
  final int lectureId;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late final PodPlayerController controller;

  bool isVideoWatched = false;

  @override
  void initState() {
    super.initState();
    final String videoType = AppService.getVideoType(widget.videoUrl);
    controller = PodPlayerController(
        playVideoFrom: videoType == 'network'
            ? PlayVideoFrom.network(widget.videoUrl)
            : videoType == 'vimeo'
                ? PlayVideoFrom.vimeo(widget.videoUrl)
                : PlayVideoFrom.youtube(widget.videoUrl),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: false,
          isLooping: false,
        ))
      ..initialise();
    controller.addListener(_checkVideoCompletion);
  }

  void _checkVideoCompletion() {
    final currentPosition = controller.currentVideoPosition.inSeconds;
    final totalDuration = controller.totalVideoLength.inSeconds;
    int process = ((currentPosition.toDouble() / totalDuration) * 100).floor();
    if (process > 95 && !isVideoWatched) {
      setState(() {
        isVideoWatched = true;
      });
      _onVideoCompleted(process);
    }
  }

  void _onVideoCompleted(
    int proccess,
  ) async {
      UpdateLessonStatusApi updateLessonStatusApi = UpdateLessonStatusApi(
        courseId: widget.courseId,
        lectureId: widget.lectureId,
        progress: proccess,
      );
      updateLessonStatusApi.call();
  }

  @override
  void dispose() {
    controller.removeListener(_checkVideoCompletion);
    if (Platform.isIOS) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    }
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PodVideoPlayer(
          controller: controller,
          alwaysShowProgressBar: true,
          videoThumbnail: widget.thumbnailUrl == null
              ? null
              : DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    widget.thumbnailUrl!,
                  ),
                ),
        ),
        const SizedBox(
          height: 4,
        ),
        if (widget.videoTitle != "")
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              widget.videoTitle,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
      ],
    );
  }
}
