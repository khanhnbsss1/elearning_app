import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/components/video_player.dart';

import '../base/widgets/audio/audio_speaker.dart';
import '../components/video_player_widget.dart';
import '../services/apis/lessson/models/lesson_info.dart';
import '../services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import '../utils/custom_cached_image.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, required this.link, required this.lesson, required this.courseId, required this.lectureId, });

  final String link;
  final LessonInfo lesson;
  final int courseId;
  final int lectureId;

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
      order.add('0');
      videoLink.add(widget.link);
      videoTitle.add(widget.lesson.lectureName??"-");
      print(videoLink);
    }
  }

  @override
  Widget build(BuildContext context) {
    LessonInfo lessonDetail = widget.lesson;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('${lessonDetail.lectureName}', style: const TextStyle(color: Colors.white),),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              FeatherIcons.chevronLeft,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(bottom: kToolbarHeight),
            child: SingleChildScrollView(
              child: Column(
                children: [
                      VideoPlayer(
                          videoUrl: videoLink[selectedVideo],
                          videoTitle: videoTitle[selectedVideo],
                          courseId: widget.courseId,
                          lectureId: widget.lectureId,
                      ),
                  if (order.isNotEmpty) Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black38
                            )
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              initiallyExpanded: true,
                              title: Text('list-of-video'.tr(),
                                  style: Theme.of(context).textTheme.titleMedium),
                              children: [
                                SizedBox(
                                  height: (order.length > 3) ? 300 : (100 * order.length).toDouble(),
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
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        if (lessonDetail.vocabularies != null)
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black38
                                )
                            ),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                initiallyExpanded: false,
                                title: Text('vocabulary'.tr(),
                                    style: Theme.of(context).textTheme.titleMedium),
                                children: [
                                      SizedBox(
                                        height: (lessonDetail.vocabularies!.length * 75) > 300 ? 300 : lessonDetail.vocabularies!.length * 75.0,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.only(top: 0, bottom: 20),
                                          itemCount: lessonDetail.vocabularies!.length,
                                          itemBuilder: (context, index) {
                                            final VocabularyInfo word =
                                            lessonDetail.vocabularies![index];
                                            return ListTile(
                                              contentPadding: const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 20),
                                              horizontalTitleGap: 10,
                                              title: Text(
                                                word.simplified!,
                                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                    fontWeight: FontWeight.w500, fontSize: 18),
                                              ),
                                              subtitle: (word.translationVn != "")
                                                  ? Text(word.translationVn ?? "-")
                                                  : const Text("-"),
                                              leading: Text(
                                                '${index + 1}.',
                                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                    fontWeight: FontWeight.bold, color: Colors.black),
                                              ),
                                              trailing: AudioSpeaker(
                                                url: word.audioLink ?? "",
                                                enableProccessBar: false,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                ],
                              ),
                            ),
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
        color: (selected) ? Colors.black.withOpacity(0.2) : Colors.white,
      ),
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.only(left: 4),
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: (videoThumbnail != "")
                ? CustomCacheImage(imageUrl: videoThumbnail, radius: 3)
                : Stack(
                  children: [
                    Center(
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode((selected) ? Colors.grey : Colors.white, BlendMode.darken),
                        child: Image.asset(
                          "assets/images/noImage1.jpg",
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    ),
                    if (selected) const Positioned(child: Center(child: Icon(Icons.play_arrow, size:48, color: Colors.black,))),
                  ]
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
