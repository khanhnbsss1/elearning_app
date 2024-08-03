import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:just_audio/just_audio.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/topic/model/topic_info.dart';
import 'package:webkit/views/course/create_edit_course/components/lectures_detail.dart';

import '../../../base/author/user_helper.dart';
import '../../../base/models/user/UserProfile.dart';
import '../../../base/theme/colors_app.dart';
import '../../../base/widgets/audio/audio_speaker.dart';
import '../../../base/widgets/button/action_button1.dart';
import '../../../base/widgets/pages_common/list_body_page_common.dart';
import '../../../helpers/utils/ui_mixins.dart';
import '../../../helpers/widgets/my_responsiv.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../../services/apis/words/word_info.dart';
import '../../video_player/model/video_model.dart';
import '../../video_player/video_player.dart';
import '../create_edit_course/components/build_tab_bar.dart';

class CourseStudyStudy extends StatefulWidget {
  final CourseInfo courseInfo;

  const CourseStudyStudy({super.key, required this.courseInfo});

  @override
  State<CourseStudyStudy> createState() => _CourseStudyStudyState();
}

class _CourseStudyStudyState extends State<CourseStudyStudy>
    with SingleTickerProviderStateMixin, UIMixin {
  @override
  void initState() {
    super.initState();
    likeCheck = List.filled(reviewCount, false);
    dislikeCheck = List.filled(reviewCount, false);
    showReply = List.filled(reviewCount, false);
    for(Subjects subject  in widget.courseInfo.getListSubjectAndLesson())
      {
        checkLecture.add(
          List.filled((subject.lectures??[]).length, false)
        );
      }
    showSubject = List.filled(
      (widget.courseInfo.getListSubjectAndLesson()??[]).length,
      false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return MyResponsive(
          builder: (buildContext, boxConstraints, myScreenMediaType) {
            return (!myScreenMediaType.isMobile)
                ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListBodyCommon(
                      minOfWidthOfListRatio: 0.5,
                      maxOfWidthOfListRatio: 0.9,
                      widthOfListRatio: 0.7,
                      enableDragIcon: true,
                      diverWall: ColorConst.dividerColor,
                      list: buildStudySection(),
                      body: Align(
                          alignment: Alignment.topCenter,
                          child: buildLectureList()))),
            )
                : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: buildStudySection(),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildStudySection() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildVideo(),
            buildStudyTitle(),
            (MediaQuery.of(context).size.width < 550)
                ? buildLectureList()
                : SizedBox(),
            // SizedBox(
            //   height: 16,
            // ),
            BuildTabBar(
              widgets: [
                buildStudyOverview(),
                buildStudyReview(),
                buildStudyQuiz(),
              ],
              titles: const ['Overview', 'Review', 'Quiz'],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVideo() {
    return SizedBox(
      height: 450,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: VideoPlayer(
            videoPlayerModel: VideoPlayerModel(
                title: "",
                link: "https://www.youtube.com/watch?v=jxAljZD0B7Q&list=PL7K6oq4k49igroleELfyc8BCoZAkgjDmZ&index=4"//widget.courseInfo.videoPreview ?? ""
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStudyTitle() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.courseInfo.name!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: ColorConst.textColor,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  'Giảng viên: ${widget.courseInfo.producerName!}',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: ColorConst.textColor,
                  ),
                ),
                Spacer(),
                StarRating(
                  color: Colors.yellow,
                  allowHalfRating: true,
                  rating: widget.courseInfo.ratePoint!.toDouble(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  List<bool> showSubject = [];
  List<List<bool>> checkLecture = [];
  int subjectCount = 4;
  int lectureCount = 3;

  double _checkProgression({required int subjectIndex}) {
    int finished = 0;
    for (bool check in checkLecture[subjectIndex].toList()) {
      if (check) finished++;
    }
    return finished /( (checkLecture[subjectIndex].isNotEmpty)?checkLecture[subjectIndex].length:1);
  }

  Widget buildLectureList() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (MediaQuery.of(context).size.width < 550)
                    ? Text('Danh sách bài học: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ))
                    : SizedBox(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: (widget.courseInfo.getListSubjectAndLesson()??[]).length,
                  itemBuilder: (context, subjectIndex) {
                    return StatefulBuilder(
                      builder: (BuildContext context,
                          void Function(void Function()) setState) {
                        Subjects subject =(widget.courseInfo.getListSubjectAndLesson()??[]).elementAt(subjectIndex);
                        return Column(
                          children: [
                            InkWell(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    margin: EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 10,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${L10nX.getStr.subject_str} $subjectIndex: ${subject.subName}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 32.0),
                                                child: Row(
                                                  children: [
                                                    (MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                        1050)
                                                        ? Text('Tiến độ: ')
                                                        : SizedBox(),
                                                    Container(
                                                      width:
                                                      constraints.maxWidth /
                                                          2,
                                                      height: 20,
                                                      constraints: BoxConstraints(
                                                        minWidth: 100,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                      ),
                                                      child: Stack(children: [
                                                        Positioned(
                                                            left: 0,
                                                            child: Container(
                                                              width: constraints.maxWidth / 2 * _checkProgression(subjectIndex: subjectIndex),
                                                              height: 20,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors.red,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    20),
                                                              ),
                                                            )),
                                                        Center(
                                                            child: Text(
                                                              '${(_checkProgression(subjectIndex: subjectIndex) * 100).floor()} %',
                                                              style: TextStyle(
                                                                  color:
                                                                  Colors.white),
                                                            )),
                                                      ]),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Flexible(
                                          flex: 1,
                                          child: (!showSubject[subjectIndex])
                                              ? Icon(
                                            Icons.arrow_drop_down,
                                            size: 32,
                                          )
                                              : Icon(Icons.arrow_drop_up,
                                              size: 32),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  showSubject[subjectIndex] =
                                  !showSubject[subjectIndex];
                                });
                              },
                            ),
                            AnimatedSize(
                              curve: Curves.fastOutSlowIn,
                              duration: Duration(milliseconds: 200),
                              child: showSubject[subjectIndex]
                                  ? Container(
                                margin: EdgeInsets.all(16),
                                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/3),
                                child: SingleChildScrollView(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: (subject.lectures??[]).length,
                                    itemBuilder: (context, lectureIndex) {
                                      LessonInfo lessonInfo = (subject.lectures??[]).elementAt(lectureIndex);
                                      return Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 32,
                                                top: 16,
                                                bottom: 16,
                                                right: 32),
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  flex: 10,
                                                  child: Text(
                                                    '${L10nX.getStr.lecture_name_str} $lectureIndex: ${lessonInfo.lectureName}',
                                                    maxLines: 2,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Spacer(),
                                                Flexible(
                                                  flex: 1,
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        checkLecture[subjectIndex][lectureIndex] = !checkLecture[subjectIndex][lectureIndex];
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 24,
                                                      height: 24,
                                                      decoration:
                                                      BoxDecoration(
                                                          border:
                                                          Border.all(
                                                            color: Colors.red,
                                                          )),
                                                      child: Align(
                                                        alignment:
                                                        Alignment.center,
                                                        child: checkLecture[subjectIndex][lectureIndex]
                                                            ? Icon(
                                                          Icons.check,
                                                          color: Colors
                                                              .red,
                                                        )
                                                            : SizedBox(),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Divider(
                                              color: Colors.black
                                                  .withOpacity(0.1),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              )
                                  : SizedBox(),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildStudyOverview() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'Introduction: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text('${widget.courseInfo.introduction}'),
          SizedBox(
            height: 16,
          ),
          Text(
            'Tài liệu: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text('Chưa lấy dữ liệu'),
          SizedBox(
            height: 16,
          ),
          Text(
            'Danh sách từ vựng',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 500,
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return buildWordItem(
                      word: WordInfo(
                          simplified: '吃',
                          traditional: '吃',
                          pinyinTones: 'chī',
                          translationVn: 'ăn',
                          audio: null));
                }),
          )
        ],
      ),
    );
  }

  bool isOnVolume = false;

  Widget buildWordItem({required WordInfo word}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Text('$index.'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${word.pinyinTones}'),
                  Row(
                    children: [
                      // Text('$index.'),
                      Text('${word.simplified} : '),
                      Text('${word.translationVn}'),
                      SizedBox(
                        width: 16,
                      ),
                      StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return InkWell(
                              onTap: () async {
                                final player = AudioPlayer();
                                player.playerStateStream.listen(
                                      (event) {
                                    switch (event.processingState) {
                                      case ProcessingState.idle:
                                      // TODO: Handle this case.
                                      case ProcessingState.loading:
                                      // TODO: Handle this case.
                                      case ProcessingState.buffering:
                                      // TODO: Handle this case.
                                      case ProcessingState.ready:
                                      // TODO: Handle this case.
                                        setState(
                                              () {
                                            isOnVolume = true;
                                          },
                                        );
                                      case ProcessingState.completed:
                                      // TODO: Handle this case.
                                        setState(
                                              () {
                                            isOnVolume = false;
                                          },
                                        );
                                    }
                                  },
                                ); // Create a player
                                await player.setUrl('https://foo.com/bar.mp3');
                                player.play();
                              },
                              child: AudioSpeaker(
                                url: word.audio?.filename ?? "",
                              ));
                        },
                      )
                    ],
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.remove_red_eye_outlined)),
              SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Divider(
          color: Colors.black.withOpacity(0.2),
        ),
        SizedBox(
          height: 4,
        ),
      ],
    );
  }

  Review review = Review(
    username: 'username 1',
    text: '',
    rating: 5,
    likeCount: 0,
    dislikeCount: 0,
    avatar: null,
  );

  List<Review> listOfReview = [];

  int reviewCount = 10;

  Widget buildStudyReview() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            '4 Reviews',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          buildStudyReviewItemUser(replyCheck: false),
          SizedBox(
              height: 500,
              child: StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: reviewCount,
                      itemBuilder: (context, index) {
                        listOfReview.add(
                          Review(
                            username: 'username $index',
                            text: 'review $index',
                            rating: 5,
                            likeCount: 0,
                            dislikeCount: 0,
                            avatar: null,
                          ),
                        );
                        return Column(
                          children: [
                            buildStudyReviewItem(
                                review: listOfReview[index], index: index),
                            SizedBox(
                              height: 16,
                            )
                          ],
                        );
                      });
                },
              )
          )
        ],
      ),
    );
  }

  Widget buildStudyReviewItemUser({required bool replyCheck}) {
    double _rating = 5;
    TextEditingController controller = TextEditingController();
    final List<String> menuItems = ['Item 1', 'Item 2', 'Item 3'];
    bool check = false;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: !replyCheck,
          child: Expanded(
            flex: 1,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 60, maxHeight: 60),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Icon(Icons.face),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Rate and comment',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    StarRating(
                      rating: _rating,
                      onRatingChanged: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                  ],
                ),
                Stack(children: [
                  TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: replyCheck ? 'Trả lời...' : 'Bình luận...',
                      alignLabelWithHint: true,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      // prefixIcon: const Icon(
                      //   LucideIcons.lock,
                      //   size: 20,
                      // ),
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    minLines: 3,
                    maxLines: 6,
                    onChanged: (value) {
                      // setState(() {
                      //   controller.text = value;
                      //   (controller.text.isEmpty) ? check = false : check = true;
                      // });
                    },
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: PopupMenuButton<String>(
                        icon: Icon(Icons.tag_faces),
                        onSelected: (value) {
                          controller.text += value;
                        },
                        itemBuilder: (context) {
                          return menuItems.map((item) {
                            return PopupMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList();
                        }),
                  )
                ]),
                Visibility(
                  visible: !check,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ActionButton1(
                      text: replyCheck ? 'Trả lời' : 'Bình luận',
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  List<bool> likeCheck = [];
  List<bool> dislikeCheck = [];
  List<bool> showReply = [];

  Widget buildStudyReviewItem({required Review review, required int index}) {
    return Column(children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 60, maxHeight: 60),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Icon(Icons.face),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        review.username,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      StarRating(
                        rating: review.rating,
                        size: 16,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: Text(
                      review.text,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.thumb_up_alt_rounded,
                          color: (likeCheck[index]) ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            likeCheck[index] = !likeCheck[index];
                            (likeCheck[index])
                                ? review.likeCount++
                                : review.likeCount--;
                          });
                        },
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text('${review.likeCount}'),
                      SizedBox(
                        width: 16,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.thumb_down_alt_rounded,
                          color:
                              (dislikeCheck[index]) ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            dislikeCheck[index] = !dislikeCheck[index];
                            (dislikeCheck[index])
                                ? review.dislikeCount++
                                : review.dislikeCount--;
                          });
                        },
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text('${review.dislikeCount}'),
                      SizedBox(
                        width: 32,
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              showReply = List.filled(reviewCount, false);
                              showReply[index] = !showReply[index];
                            });
                          },
                          child: Text('Reply')),
                    ],
                  ),
                  Visibility(
                      visible: showReply[index],
                      child: Padding(
                          padding: EdgeInsets.only(left: 60),
                          child: Container(
                              // width: MediaQuery.of(context).size.width,
                              child:
                                  buildStudyReviewItemUser(replyCheck: true))))
                ],
              )),
        ],
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Divider(
          color: Colors.black.withOpacity(0.1),
        ),
      )
    ]);
  }

  Future<UserProfile?> getProfile() async {
    UserProfile? userInfo = await UserManager().getUserProfile();
    return userInfo;
  }

  Widget buildStudyQuiz() {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Text('data')
      ],
    );
  }
}

class Review {
  final String username;
  final String text;
  final double rating;
  int likeCount;
  int dislikeCount;
  final Image? avatar;

  Review({
    required this.username,
    required this.text,
    required this.rating,
    required this.likeCount,
    required this.dislikeCount,
    required this.avatar,
  });
}
