import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webkit/views/video_player/model/video_model.dart';

/// Stateful widget to fetch and then display video content.
class FlutterVideoPlayerPage extends StatefulWidget {
  VideoPlayerModel videoPlayerModel;
  FlutterVideoPlayerPage({super.key, required this.videoPlayerModel});

  @override
  _FlutterVideoPlayerPageState createState() => _FlutterVideoPlayerPageState();
}

class _FlutterVideoPlayerPageState extends State<FlutterVideoPlayerPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        widget.videoPlayerModel.link))..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          print("object");
        });
      });
    _controller.addListener(() {
      if(_controller.value.isCompleted)
        {
          setState(() {
            
          });
        }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
              children: [
                VideoPlayer(_controller),
                Center(
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                  ),
                )
              ]
          ),
        ) : Container(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}