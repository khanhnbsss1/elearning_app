import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';

import '../../../base/widgets/button/action_button1.dart';
import '../../video_player/model/video_model.dart';
import '../../video_player/video_player.dart';

class CourseStudyIntroduction extends StatefulWidget {
  final CourseInfo courseInfo;

  const CourseStudyIntroduction({super.key, required this.courseInfo});

  @override
  State<CourseStudyIntroduction> createState() =>
      _CourseStudyIntroductionState();
}

class _CourseStudyIntroductionState extends State<CourseStudyIntroduction> {
  late List<String> courseObject = widget.courseInfo.infoObj?.split("&&&").map((e) => e.trim()).toList() ?? [];

  late List<String> courseResult = widget.courseInfo.infoResult?.split("&&&").map((e) => e.trim()).toList() ?? [];
  @override
  void initState() {
    super.initState();
  }
  //
  // courseObject = widget.courseInfo.infoObj?.split("&&&").map((e) => e.trim()).toList() ?? [];
  // courseResult = widget.courseInfo.infoResult?.split("&&&").map((e) => e.trim()).toList() ?? [];

  @override
  Widget build(BuildContext context) {
    for (String s in courseObject) {
      print('==========================> ${s}');
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Expanded(
                  flex: 6,
                  child: Align(
                      alignment: Alignment.topLeft, child: buildInfoBox())),
              Flexible(
                  flex: 4,
                  child: Align(
                      alignment: Alignment.topCenter, child: buildInfoCard())),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoBox() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildVideo(),
            SizedBox(
              height: 16,
            ),
            buildInfoBoxIntroduction(),
            SizedBox(
              height: 16,
            ),
            buildInfoBoxInfoObj(),
            SizedBox(
              height: 16,
            ),
            buildInfoBoxInfoResult(),
            SizedBox(
              height: 16,
            ),
            buildInfoBoxTag(),
          ],
        ),
      ),
    );
  }

  Widget buildVideo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 450,
      child: VideoPlayer(
        videoPlayerModel: VideoPlayerModel(
            title: "",
            link:
            "https://www.youtube.com/watch?v=jxAljZD0B7Q&list=PL7K6oq4k49igroleELfyc8BCoZAkgjDmZ&index=4" //widget.courseInfo.videoPreview ?? ""
        ),
      ),
    );
  }

  Widget buildInfoBoxIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Giới thiệu khóa học: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text('${widget.courseInfo.introduction}'),
      ],
    );
  }

  Widget buildInfoBoxInfoObj() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Khóa học này dành cho: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: (widget.courseInfo.infoResult != null)
              ? ListView.builder(
              shrinkWrap: true,
              itemCount: courseObject.length,
              itemBuilder: (context, index) => Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Text(courseObject[index]),
                  SizedBox(height: Dimens.size10,)
                ],
              ))
              : Text('${widget.courseInfo.infoResult}'),
        ),
      ],
    );
  }

  Widget buildInfoBoxInfoResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bạn nhận được gì sau khóa học này:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: (widget.courseInfo.infoResult != null)
              ? ListView.builder(
              shrinkWrap: true,
              itemCount: courseResult.length,
              itemBuilder: (context, index) => Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Text(courseResult[index])
                ],
              ))
              : Text('${widget.courseInfo.infoResult}'),
        ),
      ],
    );
  }

  Widget buildInfoBoxTag() {
    final tags = widget.courseInfo.tags;
    try {
      print(widget.courseInfo.lectures?.first);
    } catch (e) {
      print(e);
    }
    if (tags == null || tags.isEmpty) {
      return const Text(
        "Tags: No tags",
        style: TextStyle(fontSize: 14),
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Tags:   ",
            style: const TextStyle(fontSize: 16),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tags.map((tag) {
                return Row(
                  children: [
                    Text(
                      tag.name ?? "Unnamed tags",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                );
              }).toList(),
            ),
          )
        ],
      );
    }
  }

  Widget buildInfoCard() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                  )),
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        (widget.courseInfo.image == null)
                            ? 'assets/deshboard/adventure/adventure5.png'
                            : widget.courseInfo.image!,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'assets/deshboard/adventure/adventure5.png',
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return SizedBox();
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Phân loại:'),
                              SizedBox(
                                height: 8,
                              ),
                              Text('Tác giả: '),
                              SizedBox(
                                height: 8,
                              ),
                              Text('Thời lượng: '),
                              SizedBox(
                                height: 8,
                              ),
                              Text('Nội dung: '),
                              SizedBox(
                                height: 8,
                              ),
                              Text('Chính quy: '),
                              SizedBox(
                                height: 8,
                              ),
                              Text('ID: '),
                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.courseInfo.gradeName ?? '-'),
                              SizedBox(
                                height: 8,
                              ),
                              Text(widget.courseInfo.producerName ?? '-'),
                              SizedBox(
                                height: 8,
                              ),
                              Text(widget.courseInfo.durian ?? '-'),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                  '${widget.courseInfo.totalSubjects} chủ đề, ${widget.courseInfo.totalLectures} bài học'),
                              SizedBox(
                                height: 8,
                              ),
                              Text('${widget.courseInfo.isStandard ?? '0'}'),
                              SizedBox(
                                height: 8,
                              ),
                              Text('${widget.courseInfo.id ?? '0'}'),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: Colors.black.withOpacity(0.1))),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              '${widget.courseInfo.payment! / 0.8} VND',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black45,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '${widget.courseInfo.payment!} VND',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xFFFFC711),
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFFFFC711),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            ActionButton1(
                              text: 'Đăng ký ngay',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
