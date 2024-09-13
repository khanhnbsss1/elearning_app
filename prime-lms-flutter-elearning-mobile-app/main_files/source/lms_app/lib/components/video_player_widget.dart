// import 'dart:io';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:lms_app/services/app_service.dart';
// import 'package:pod_player/pod_player.dart';
//
// class VideoPlayerWidget extends StatefulWidget {
//   const VideoPlayerWidget({
//     super.key,
//     required this.videoUrl,
//     this.thumbnailUrl,
//   });
//
//   final String videoUrl;
//   final String? thumbnailUrl;
//
//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late final PodPlayerController controller;
//   bool isVideoWatched = false;
//
//   @override
//   void initState() {
//     final String videoType = AppService.getVideoType(widget.videoUrl);
//     controller = PodPlayerController(
//         playVideoFrom: videoType == 'network'
//             ? PlayVideoFrom.network(widget.videoUrl)
//             : videoType == 'vimeo'
//             ? PlayVideoFrom.vimeo(widget.videoUrl)
//             : PlayVideoFrom.youtube(widget.videoUrl),
//         podPlayerConfig: const PodPlayerConfig(
//           autoPlay: false,
//           isLooping: false,
//         ))
//       ..initialise();
//     controller.addListener(_checkVideoCompletion);
//   }
//
//   void _checkVideoCompletion() {
//     final currentPosition = controller.currentVideoPosition.inSeconds;
//     final totalDuration = controller.totalVideoLength.inSeconds;
//     print("=========================");
//     print("$currentPosition");
//     print("$totalDuration");
//
//     if (currentPosition == totalDuration && !isVideoWatched) {
//       setState(() {
//         isVideoWatched = true;
//       });
//       // Perform an action when video is completed
//       _onVideoCompleted();
//     }
//   }
//
//   void _onVideoCompleted() {
//     // Perform an action, such as logging completion or notifying the backend
//     print("User has finished watching the video.");
//     // Example: Call a service to update the user's watch status
//     // AppService.updateUserVideoCompletion(widget.videoUrl);
//   }
//
//   @override
//   void dispose() {
//     // Clean up listener
//     controller.removeListener(_checkVideoCompletion);
//     // Fix for iOS status bar issue
//     if (Platform.isIOS) {
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//           overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
//     }
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//         alignment: Alignment.topCenter,
//         child: PodVideoPlayer(
//           controller: controller,
//           alwaysShowProgressBar: true,
//           videoThumbnail: widget.thumbnailUrl == null
//               ? null
//               : DecorationImage(
//             fit: BoxFit.cover,
//             image: CachedNetworkImageProvider(
//               widget.thumbnailUrl!,
//             ),
//           ),
//         ),
//       );
//   }
// }
