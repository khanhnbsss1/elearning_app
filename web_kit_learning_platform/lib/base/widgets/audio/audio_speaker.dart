import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:webkit/base/base.export.dart';

class AudioSpeaker extends StatefulWidget {
  String url;
  AudioSpeaker({required this.url});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AudioSpeakerState();
  }
}

class AudioSpeakerState extends State<AudioSpeaker> {
  ProcessingState processingState = ProcessingState.completed;
  final player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(onTap: () async {
      await AudioManager().playAudio(
        url: widget.url,
        onChangeProcessingState: (p0) {
          setState(() {
            processingState = p0;
          });
        },
      );
    }, child: LayoutBuilder(
      builder: (context, constraints) {
        switch (processingState) {
          case ProcessingState.idle:
          // TODO: Handle this case.
          case ProcessingState.loading:
          // TODO: Handle this case.
          case ProcessingState.buffering:
            // TODO: Handle this case.
            return Icon(
              Icons.volume_down,
              color: ColorConst.mainColor,
            );
          case ProcessingState.ready:
            // TODO: Handle this case.
            return Icon(
              Icons.volume_up,
              color: ColorConst.mainColor,
            );
          case ProcessingState.completed:
            // TODO: Handle this case.
            return Icon(
              Icons.volume_down,
              color: ColorConst.mainColor,
            );
        }
      },
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    AudioManager().releaseAudio();
  }
}

class AudioManager {
  static final AudioManager _singletonAudioManagerManager = AudioManager._internal();
  static AudioManager get getInstance => _singletonAudioManagerManager;
  factory AudioManager() {
    return _singletonAudioManagerManager;
  }
  AudioManager._internal();
  AudioPlayer? player;
  Future<void> playAudio({Function(ProcessingState)? onChangeProcessingState, required String url}) async {
    if (player == null) {
      player = AudioPlayer();
    } else {
      await player?.dispose();
      await AudioPlayer.clearAssetCache();
      player = AudioPlayer();
    }
    player?.playerStateStream.listen(
      (event) async {
        if (onChangeProcessingState != null) {
          onChangeProcessingState(event.processingState);
        }
        if (event.processingState == ProcessingState.completed) {
          await AudioPlayer.clearAssetCache();
        }
      },
    );
    await player?.setUrl(url.isNotEmpty ? url : 'https://www2.cs.uic.edu/~i101/SoundFiles/BabyElephantWalk60.wav');
    try {
      await player?.play();
    } catch (e) {
      if (onChangeProcessingState != null) {
        player?.dispose();
        await AudioPlayer.clearAssetCache();
        player = AudioPlayer();
        onChangeProcessingState(ProcessingState.completed);
      }
    }
  }
  
  Future<void> releaseAudio() async {
    player?.dispose();
    await AudioPlayer.clearAssetCache();
  }
}
