import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import '../model/video_model.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

///

///
class YoutubePlayerControllerManager{
  static final YoutubePlayerControllerManager youtubePlayerControllerManager = YoutubePlayerControllerManager._internal();
  static YoutubePlayerControllerManager get getInstance => youtubePlayerControllerManager;
  factory YoutubePlayerControllerManager() {
    return youtubePlayerControllerManager;
  }
  YoutubePlayerControllerManager._internal();
  YoutubePlayerController? youTubeController;
  void onFinishVideo(){
    youTubeController?.stopVideo();
    youTubeController?.close();
  }
  void onInitController(){
    YoutubePlayerControllerManager().youTubeController = YoutubePlayerController(
      params: const YoutubePlayerParams(
          showControls: true,
          mute: false,
          showFullscreenButton: true,
          loop: false,
          enableCaption: true,
          enableJavaScript: false
      ),
    );

    YoutubePlayerControllerManager().youTubeController?.setFullScreenListener(
          (isFullScreen) {
        log('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
      },
    );
    YoutubePlayerControllerManager().youTubeController?.stopVideo();
    YoutubePlayerControllerManager().youTubeController?.listen((event) {
      switch(event.playerState){
        case PlayerState.unknown:
        // TODO: Handle this case.
        case PlayerState.unStarted:
        // TODO: Handle this case.
        case PlayerState.ended:
        // TODO: Handle this case.
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
}
class YoutubePlayerPage extends StatefulWidget {
  
  VideoPlayerModel videoPlayerModel;
  Function(Duration duration)? onGetVideoDuration;
  Function(Duration duration)? onGetVideoPosition;
  YoutubePlayerPage({super.key, required this.videoPlayerModel, this.onGetVideoDuration, this.onGetVideoPosition});
  
  @override
  State<YoutubePlayerPage> createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  late YoutubePlayerController _youTubeController;
  @override
  void initState() {
    super.initState();
    onInitController();
  }
  String getVideoIdFromVideoUrl(){
    String videoLink = widget.videoPlayerModel.link;
    String? videoId = YoutubePlayerController.convertUrlToId(videoLink);
    return videoId!;
  }
  @override
  Widget build(BuildContext context) {
    //onInitController();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) { 
        return YoutubePlayerScaffold(
         // key: widget.key,
          controller: _youTubeController,
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
                        key: widget.key,
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
  void onInitController(){
    _youTubeController = YoutubePlayerController(
      params: const YoutubePlayerParams(
          showControls: true,
          mute: false,
          showFullscreenButton: true,
          loop: false,
          enableCaption: true,
          enableJavaScript: false
      ),
    );

    _youTubeController.loadVideoById(videoId: getVideoIdFromVideoUrl());
    _youTubeController.stopVideo();
    _youTubeController.setFullScreenListener(
          (isFullScreen) {
        log('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
      },
    );
    _youTubeController.listen((event) {
      switch(event.playerState){
        case PlayerState.unknown:
        // TODO: Handle this case.
        case PlayerState.unStarted:
        // TODO: Handle this case.
        case PlayerState.ended:
        // TODO: Handle this case.
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
  void onFinishVideo(){
    _youTubeController.stopVideo();
    _youTubeController.close();
  }
  
  @override
  void dispose() {
    onFinishVideo();
    super.dispose();
  }
  
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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
          YoutubePlayerControllerManager().youTubeController = context.ytController;
          
        }
        return LinearProgressIndicator(
          value: duration == 0 ? 0 : position / duration,
          minHeight: 1,
        );
      },
    );
  }
}

