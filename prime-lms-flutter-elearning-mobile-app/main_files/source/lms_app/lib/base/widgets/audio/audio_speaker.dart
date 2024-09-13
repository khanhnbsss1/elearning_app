import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';

import '../../../screens/sound.dart';
import '../../constant/dimens_constant.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AudioSpeaker extends StatefulWidget {
  String url;
  bool? enableProccessBar;
  double? size;

  AudioSpeaker(
      {super.key, required this.url, this.enableProccessBar, this.size}) {
    enableProccessBar ??= false;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AudioSpeakerState();
  }
}

class AudioSpeakerState extends State<AudioSpeaker> {
  ProcessingState processingState = ProcessingState.buffering;
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
    if (widget.enableProccessBar != true) {
      return InkWell(onTap: () async {
        setState(() {
          processingState = ProcessingState.loading;
        });
        AudioManager().playAudio(
          url: widget.url,
          onChangeProcessingState: (state) {
            setState(() {
              processingState = state;
            });
          },
          onGetLength: (length) {
            Timer.periodic(length ?? const Duration(seconds: 0), (Timer t) {
              setState(() {
                processingState = ProcessingState.completed;
              });
              t.cancel();
            });
          },
        );
      }, child: LayoutBuilder(
        builder: (context, constraints) {
          Widget icon = const SizedBox();
          switch (processingState) {
            case ProcessingState.idle:
            // TODO: Handle this case.
            case ProcessingState.loading:
            // TODO: Handle this case.
            case ProcessingState.buffering:
              // TODO: Handle this case.
              return icon = Icon(
                Icons.volume_down,
                size: widget.size ?? 24,
                color: Theme.of(context).primaryColor,
              );
            case ProcessingState.ready:
              // TODO: Handle this case.
              icon = Icon(
                Icons.volume_up,
                size: widget.size ?? 24,
                color: Theme.of(context).primaryColor,
              );
            case ProcessingState.completed:
              // TODO: Handle this case.
              icon = Icon(
                Icons.volume_down,
                size: widget.size ?? 24,
                color: Theme.of(context).primaryColor,
              );
          }
          return icon;
        },
      ));
    } else {
      AudioManager().playAudio(
        url: widget.url,
        onChangeProcessingState: (state) {
          setState(() {
            processingState = state;
          });
        },
        onGetLength: (lengthAudio) {
          setState(() {
            length = lengthAudio;
          });
          Timer.periodic(length ?? const Duration(seconds: 0), (Timer t) {
            setState(() {
              processingState = ProcessingState.completed;
            });
            t.cancel();
          });
        },
      );
      return InkWell(
        onTap: () {

        },
        child: SizedBox(
          width: Dimens.size200,
          child: SfSlider(
            min: Duration(seconds: 0).inSeconds,
            max: length??Duration(seconds: 1).inSeconds,
            stepDuration: SliderStepDuration(seconds: 1),
            dateFormat: DateFormat.ms(),
            dateIntervalType: DateIntervalType.seconds,
            showTicks: true,
            showLabels: true,
            value: (event ?? Duration(seconds: 0)).inSeconds,
            onChanged: (value) {},
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    AudioManager().releaseAudio();
  }
}

class AudioManager {
  static final AudioManager _singletonAudioManagerManager =
      AudioManager._internal();

  static AudioManager get getInstance => _singletonAudioManagerManager;

  factory AudioManager() {
    return _singletonAudioManagerManager;
  }

  AudioManager._internal();

  AudioPlayer? player;

  Future<void> playAudio(
      {Function(ProcessingState)? onChangeProcessingState,
      required String url,
      Function(Duration event)? onChangeDuration,
      Function(Duration? length)? onGetLength}) async {
    player;
    if (player == null) {
      player = AudioPlayer();
    } else {
      releaseAudio();
      player = AudioPlayer();
    }
    player?.positionStream.listen(
      (event) {
        if (onChangeDuration != null) {
          onChangeDuration(event);
        }
      },
    );
    player?.playerStateStream.listen(
      (event) async {
        if (onChangeProcessingState != null) {
          onChangeProcessingState(event.processingState);
        }
        if (event.processingState == ProcessingState.completed) {
          if (onChangeProcessingState != null) {
            onChangeProcessingState(event.processingState);
          }
          await AudioPlayer.clearAssetCache();
        }
      },
    );
    Duration? length = await player?.setUrl(url);

    if (onGetLength != null) {
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
