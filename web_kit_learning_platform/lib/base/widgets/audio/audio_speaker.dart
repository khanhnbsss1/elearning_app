import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:webkit/base/base.export.dart';

class AudioSpeaker extends StatefulWidget {
  String url;
  bool? enableProccessBar;
  AudioSpeaker({super.key, required this.url, this.enableProccessBar}){
    enableProccessBar??=false;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AudioSpeakerState();
  }
}

class AudioSpeakerState extends State<AudioSpeaker> {
  ProcessingState processingState = ProcessingState.completed;
  Duration? length, event; 
  final player = AudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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
        onChangeDuration: (event) {
          setState(() {
            event = event;
          });
        },
        onGetLength: (length) {
          length = length;
        },
      );
    }, child: LayoutBuilder(
      builder: (context, constraints) {
        Widget icon = SizedBox();
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
            icon=  Icon(
              Icons.volume_up,
              color: ColorConst.mainColor,
            );
          case ProcessingState.completed:
            // TODO: Handle this case.
            icon=  Icon(
              Icons.volume_down,
              color: ColorConst.mainColor,
            );
        }
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: false,
                child: Row(
                  children: [
                    SizedBox(
                      width: Dimens.size200,
                      child: SfSlider(
                        min: Duration(seconds: 0).inSeconds,
                        max: length??Duration(seconds: 1).inSeconds,
                        stepDuration: SliderStepDuration(seconds: 1),
                        dateFormat: DateFormat.ms(),
                        dateIntervalType: DateIntervalType.seconds,
                        showTicks: true,
                        showLabels: true,
                        value: (event??Duration(seconds: 0)).inSeconds, onChanged: (value) {  },
                      ),
                    ),
                    Gap(Dimens.size8),
                  ],
                )),
            icon
          ],
        );
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
  Future<void> playAudio(
      {
        Function(ProcessingState)? onChangeProcessingState,
        required String url,
        Function(Duration event)? onChangeDuration,
        Function(Duration? length)? onGetLength
      }) async {
    if (player == null) {
      player = AudioPlayer();
    } else {
      await player?.dispose();
      await AudioPlayer.clearAssetCache();
      player = AudioPlayer();
    }
    player?.positionStream.listen((event) {
      if (onChangeDuration != null) {
        onChangeDuration(event);
      }
    },);
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
   Duration? length =  await player?.setUrl(url);
   
   if(onGetLength!=null) {
     onGetLength(length);
   }
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
