import 'dart:convert';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/components/video_player.dart';

import '../components/video_player_widget.dart';
import '../utils/custom_cached_image.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, required this.link});

  final String link;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  List<String> order = [];
  List<String> videoTitle = [];
  List<String> videoLink = [];

  List<Widget> listOfVideo = [];

  // for (int i = 0; i < order.length; i++) {
  //   listOfVideo.add(videoListItem(videoTitle[i], ""));
  // }
  int selectedVideo = 0;

  @override
  void initState() {
    super.initState();
    try {
      Map<String, dynamic> linkJson = jsonDecode(widget.link);

      List<dynamic> linkList = linkJson['link'];

      for (var video in linkList) {
        order.add('${video['order']}');
        videoTitle.add('${video['videoTitle']}');
        videoLink.add('${video['videoLink']}');
      }
    } catch (e) {
      videoLink.add(widget.link);
      print(videoLink);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Video'),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              FeatherIcons.chevronLeft,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(bottom: kToolbarHeight),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  (videoLink.length == videoTitle.length)
                      ? VideoPlayer(
                          videoUrl: videoLink[selectedVideo],
                          videoTitle: videoTitle[selectedVideo])
                      : VideoPlayerWidget(
                          videoUrl: videoLink[0],
                        ),
                  if (order.isNotEmpty) Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('List of video',
                            style: Theme.of(context).textTheme.titleMedium),
                        SizedBox(
                          height: 600,
                          child: ListView.builder(
                              itemCount: order.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedVideo = index;
                                      });
                                    },
                                    child: videoListItem(videoTitle[index], "",
                                        index == selectedVideo));
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget videoListItem(
      String videoTitle, String? videoThumbnail, bool selected) {
    return Container(
      decoration: BoxDecoration(
        color: (selected) ? Colors.grey.withOpacity(0.2) : Colors.white,
      ),
      margin: const EdgeInsets.all(8.0),
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: (videoThumbnail != "")
                ? CustomCacheImage(imageUrl: videoThumbnail, radius: 3)
                : Center(
                    child: Image.asset("assets/images/noImage.jpg",
                        fit: BoxFit.fitHeight),
                  ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                videoTitle,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
