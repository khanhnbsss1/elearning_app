import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import '../model/video_model.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

///

///
class YoutubePlayerPage extends StatefulWidget {
  VideoPlayerModel videoPlayerModel;
  Function(Duration duration)? onGetVideoDuration;
  Function(Duration duration)? onGetVideoPosition;
  YoutubePlayerPage({required this.videoPlayerModel, this.onGetVideoDuration, this.onGetVideoPosition});
  @override
  State<YoutubePlayerPage> createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
        enableCaption: true,
        enableJavaScript: false
      ),
    );

    _controller.setFullScreenListener(
          (isFullScreen) {
        log('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
      },
    );
    _controller.loadVideo(widget.videoPlayerModel.link);
    _controller.listen((event) {
      switch(event.playerState){
        case PlayerState.unknown:
          // TODO: Handle this case.
        case PlayerState.unStarted:
          // TODO: Handle this case.
        case PlayerState.ended:
          // TODO: Handle this case.
          onFinishVideo();
        case PlayerState.playing:
          // TODO: Handle this case.
        case PlayerState.paused:
          // TODO: Handle this case.
        case PlayerState.buffering:
          // TODO: Handle this case.
        case PlayerState.cued:
          // TODO: Handle this case.
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) { 
        return YoutubePlayerScaffold(
          controller: _controller,
          backgroundColor: ColorConst.blackColor,
          //aspectRatio: constraints.maxWidth/constraints.maxHeight,
          builder: (context, player) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  height: constraints.maxHeight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: player),
                      VideoPositionIndicator(
                        onGetVideoDuration: (duration) {
                          if(widget.onGetVideoDuration!=null)
                            {
                              widget.onGetVideoDuration!(duration);
                            }
                        },
                        onGetVideoPosition: (duration) {
                          if(widget.onGetVideoPosition!=null)
                          {
                            widget.onGetVideoPosition!(duration);
                          }
                        },
                      ),
                      //const VideoPositionSeeker(),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
  
  void onFinishVideo(){
    
  }
}


///
class VideoPositionIndicator extends StatelessWidget {
  ///
  VideoPositionIndicator({super.key, this.onGetVideoDuration, this.onGetVideoPosition});
  Function(Duration duration)? onGetVideoDuration;
  Function(Duration duration)? onGetVideoPosition;
  @override
  Widget build(BuildContext context) {
    final controller = context.ytController;
    return StreamBuilder<YoutubeVideoState>(
      stream: controller.videoStateStream,
      initialData: const YoutubeVideoState(),
      builder: (context, snapshot) {
        final position = snapshot.data?.position.inMilliseconds ?? 0;
        final duration = controller.metadata.duration.inMilliseconds;
        if(onGetVideoDuration!=null)
          {
            onGetVideoDuration!(controller.metadata.duration);
          }
        if(onGetVideoPosition!=null && snapshot.hasData)
        {
          onGetVideoPosition!(snapshot.data!.position);
        }
        return LinearProgressIndicator(
          value: duration == 0 ? 0 : position / duration,
          minHeight: 1,
        );
      },
    );
  }
}

///
class VideoPositionSeeker extends StatelessWidget {
  ///
  const VideoPositionSeeker({super.key});

  @override
  Widget build(BuildContext context) {
    var value = 0.0;
    return Row(
      children: [
        const SizedBox(width: 14),
        Expanded(
          child: StreamBuilder<YoutubeVideoState>(
            stream: context.ytController.videoStateStream,
            initialData: const YoutubeVideoState(),
            builder: (context, snapshot) {
              final position = snapshot.data?.position.inSeconds ?? 0;
              final duration = context.ytController.metadata.duration.inSeconds;

              value = position == 0 || duration == 0 ? 0 : position / duration;

              return StatefulBuilder(
                builder: (context, setState) {
                  return Slider(
                    value: value,
                    onChanged: (positionFraction) {
                      value = positionFraction;
                      setState(() {});
                      context.ytController.seekTo(
                        seconds: (value * duration).toDouble(),
                        allowSeekAhead: true,
                      );
                    },
                    min: 0,
                    max: 1,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}