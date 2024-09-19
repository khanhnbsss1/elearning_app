import 'dart:async';
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
    required this.currentOrder,
    required this.totalOrder,
    required this.onCompleted,
  });

  final String videoTitle;
  final String videoUrl;
  final String? thumbnailUrl;
  final int currentOrder;
  final int totalOrder;
  final Function(int)? onCompleted;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late final PodPlayerController controller;

  int count = 0;

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

  @override
  void didUpdateWidget(VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _updateVideo();
    }
  }

  Future<void> _updateVideo() async {
    final String videoType = AppService.getVideoType(widget.videoUrl);
    await controller.changeVideo(
      playVideoFrom: videoType == 'network'
          ? PlayVideoFrom.network(widget.videoUrl)
          : videoType == 'vimeo'
              ? PlayVideoFrom.vimeo(widget.videoUrl)
              : PlayVideoFrom.youtube(widget.videoUrl),
    );

    controller.addListener(_checkVideoCompletion);
  }

  void _checkVideoCompletion() {
    final currentPosition = controller.currentVideoPosition.inSeconds;
    final totalDuration = controller.totalVideoLength.inSeconds;
    int progress = currentPosition * 100 ~/ totalDuration;
    if (widget.currentOrder < widget.totalOrder && progress == 100) {
      controller.removeListener(_checkVideoCompletion);
      widget.onCompleted!(widget.currentOrder + 1);
    } else {
      if (widget.currentOrder == widget.totalOrder && progress > 95) {
        widget.onCompleted!(widget.currentOrder);
      }
    }
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
    // controller.addListener(_checkVideoCompletion);
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
