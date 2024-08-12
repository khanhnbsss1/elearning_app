import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/views/video_player/video_player/video_player.dart';
import 'package:webkit/views/video_player/youtube_player/youtube_layer.dart';

import 'model/video_model.dart';


class VideoPlayer extends  StatefulWidget{
  VideoPlayer({super.key, required this.videoPlayerModel});
  VideoPlayerModel videoPlayerModel;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VideoPlayerState();
  }
  
}
class VideoPlayerState extends  State<VideoPlayer>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(checkVideoFromYoutube()){
     return YoutubePlayerPage(videoPlayerModel: widget.videoPlayerModel,);
   }
   else
   {
     return FlutterVideoPlayerPage(videoPlayerModel: widget.videoPlayerModel,);
   }
    /* Material(
    child: CustomDialog1(
         title: widget.videoPlayerModel.title,
         titleAlignment: MainAxisAlignment.center,
         insetPadding: EdgeInsets.symmetric(vertical: Dimens.size10),
         width: MediaQuery.of(context).size.width*(ResponsiveInfo.isPhone()?1: 1),
         enableBackButton: false,
         enableCloseButton: false,
         radius: 0,
         mainAxisSizeParent: MainAxisSize.max,
         child: Expanded(
             child: LayoutBuilder(builder: (context, constraints) {
               if(checkVideoFromYoutube()){
                 return YoutubePlayerPage(videoPlayerModel: widget.videoPlayerModel,);
               }
               else
                 {
                   return FlutterVideoPlayerPage(videoPlayerModel: widget.videoPlayerModel,);
                 }
             },)
         )
     ),
   );*/
  }
  bool checkVideoFromYoutube(){
    return widget.videoPlayerModel.link.contains("youtube.com");
  }
  
}