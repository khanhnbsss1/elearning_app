import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:webkit/base/base.export.dart';

class AudioSpeaker extends StatefulWidget{
  String url;
  AudioSpeaker({required this.url});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AudioSpeakerState();
  }
  
}
class AudioSpeakerState extends State<AudioSpeaker>{
  ProcessingState processingState = ProcessingState.completed;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
        onTap: () async {
          if(processingState == ProcessingState.completed){
            final player = AudioPlayer();
            player.playerStateStream.listen((event) async {
              processingState = event.processingState;
              if(processingState == ProcessingState.completed)
                {
                  await AudioPlayer.clearAssetCache();
                }
            },);// Create a player
            await player.setUrl(widget.url.isNotEmpty?widget.url:'https://foo.com/bar.mp3');
            try{
              player.play();
            }
            catch (e){
              processingState = ProcessingState.completed;
            }
          }
        },
        child: LayoutBuilder(builder: (context, constraints) {
          switch(processingState){
            
            case ProcessingState.idle:
              // TODO: Handle this case.
            case ProcessingState.loading:
              // TODO: Handle this case.
            case ProcessingState.buffering:
              // TODO: Handle this case.
            return Icon(Icons.volume_down, color: ColorConst.mainColor,);
            case ProcessingState.ready:
              // TODO: Handle this case.
              return Icon(Icons.volume_up, color: ColorConst.mainColor,);
            case ProcessingState.completed:
              // TODO: Handle this case.
              return Icon(Icons.volume_down, color: ColorConst.mainColor,);

          }
        },)
    );
  }

}