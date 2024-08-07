import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/topic/model/topic_info.dart';
import 'package:webkit/services/apis/vocabulary/words/word_info.dart';
import 'package:webkit/views/course/course_detail/bloc/course_detail_bloc.dart';

import '../../../base/widgets/audio/audio_speaker.dart';
import '../../../helpers/utils/ui_mixins.dart';
import '../../../helpers/widgets/my_responsiv.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../video_player/model/video_model.dart';
import '../../video_player/video_player.dart';
import '../create_edit_course/components/build_tab_bar.dart';

class CourseStudyStudy extends StatefulWidget {
  const CourseStudyStudy({super.key});

  @override
  State<CourseStudyStudy> createState() => _CourseStudyStudyState();
}

class _CourseStudyStudyState extends State<CourseStudyStudy> with SingleTickerProviderStateMixin, UIMixin {
  ScrollController subjectScrollController = ScrollController();
  ScrollController lessonDetailScrollController = ScrollController();
  late CourseDetailState _state;
  late BuildContext _blocContext;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    likeCheck = List.filled(reviewCount, false);
    dislikeCheck = List.filled(reviewCount, false);
    showReply = List.filled(reviewCount, false);

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseDetailBloc, CourseDetailState>(
      listener: (context, state) {
        switch (state.blocStatus) {
          case AddCourseStatus.initial:
            
            break;
          default:
            break;
        }
      },
      builder: (BuildContext context, state) {
        _blocContext = context;
        _state = state;
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return (state.courseInfo?.getListSubjectAndLesson()??[]).isNotEmpty?MyResponsive(
              builder: (buildContext, boxConstraints, myScreenMediaType) {
                return Scaffold(
                  key: _scaffoldKey,
                  backgroundColor: ColorConst.whiteColor,
                  body: SingleChildScrollView(
                    controller: lessonDetailScrollController,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            buildStudySection(),
                            Visibility(
                              visible: boxConstraints.maxWidth <= 800,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(L10nX.getStr.lesson_list, style: TextStyleConstant.textStyleBlack18w600,),
                                      ],
                                    ),
                                    buildSubjectList(),
                                  ],
                                ),
                              ),)
                          ],
                        )),
                        Visibility(
                            visible: boxConstraints.maxWidth > 800,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                VerticalDivider(
                                  color: ColorConst.dividerColor,
                                ),
                                Column(
                                  children: [
                                    Gap(Dimens.size16),
                                    buildSubjectList(),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              },
            ):Center(child: NoData());
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
            Gap(Dimens.size10),
            buildVideo(),
            buildStudyTitle(),
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
            videoPlayerModel: VideoPlayerModel(title: "", 
                link: 
                //(_state.selectLessonInfo?.link??"").isNotEmpty?(_state.selectLessonInfo?.link??""):
                "https://www.youtube.com/watch?v=jxAljZD0B7Q&list=PL7K6oq4k49igroleELfyc8BCoZAkgjDmZ&index=4" //_state.courseInfo?.videoPreview ?? ""
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
            Gap(Dimens.size16),
            Text(
              'Bài giảng: ${_state.selectLessonInfo?.lectureName!}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: ColorConst.textColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

 

  double _checkProgression({required int subjectIndex}) {
    int finished = 0;
    for (bool check in _state.checkLecture![subjectIndex].toList()) {
      if (check) finished++;
    }
    return finished / ((_state.checkLecture![subjectIndex].isNotEmpty) ? _state.checkLecture![subjectIndex].length : 1);
  }

  Widget buildSubjectList() {
    return Container(
      width: Dimens.size400,
      decoration: BoxDecoration(
          border: Border.all(
              color: ColorConst.dividerColor, 
              width: 0.2
          ),
        borderRadius: BorderRadius.circular(20)
      ),
      child: SingleChildScrollView(
        controller: subjectScrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                scrollDirection: Axis.vertical,
                controller: subjectScrollController,
                itemCount: (_state.courseInfo?.getListSubjectAndLesson() ?? []).length,
                itemBuilder: (context, subjectIndex) {
                  return StatefulBuilder(
                    builder: (BuildContext context, void Function(void Function()) setState) {
                      Subjects subject = (_state.courseInfo?.getListSubjectAndLesson() ?? []).elementAt(subjectIndex);
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            child: Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                              child: Container(
                                margin: EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${L10nX.getStr.subject_str} $subjectIndex: ${subject.subName}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Gap(Dimens.size16),
                                        (!_state.showSubject![subjectIndex])
                                            ? Icon(
                                          Icons.arrow_drop_down,
                                          size: 32,
                                        )
                                            : Icon(Icons.arrow_drop_up, size: 32),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        (MediaQuery.of(context).size.width > 1050) ? Text('Tiến độ: ') : SizedBox(),
                                        Expanded(
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              return Container(
                                                width: constraints.maxWidth,
                                                height: 20,
                                                constraints: BoxConstraints(
                                                  minWidth: 100,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Stack(children: [
                                                  Container(
                                                    width: constraints.maxWidth * _checkProgression(subjectIndex: subjectIndex),
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                  ),
                                                  Center(
                                                      child: Text(
                                                        '${(_checkProgression(subjectIndex: subjectIndex) * 100).floor()} %',
                                                        style: TextStyle(color: Colors.white),
                                                      )),
                                                ]),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _state. showSubject![subjectIndex] = !_state.showSubject![subjectIndex];
                              });
                            },
                          ),
                          buildLessonItemList(subjectIndex: subjectIndex, subject: subject,)
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLessonItemList({required Subjects subject, required int subjectIndex, }) {
    return AnimatedSize(
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 200),
      child: _state.showSubject![subjectIndex]
          ? Container(
              margin: EdgeInsets.all(16),
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2),
              child: SingleChildScrollView(
                controller: subjectScrollController,
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: subjectScrollController,
                  itemCount: (subject.lectures ?? []).length,
                  itemBuilder: (context, lectureIndex) {
                    LessonInfo lessonInfo = (subject.lectures ?? []).elementAt(lectureIndex);
                    bool isSelectLesson = lessonInfo.id == _state.selectLessonInfo?.id;
                    return InkWell(
                      onTap: () {
                        BlocProvider.of<CourseDetailBloc>(context).add(CourseDetailSelectLessonEvent(selectLessonInfo: lessonInfo));
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: isSelectLesson?ColorConst.mainColor.withOpacity(0.05): ColorConst.whiteColor,
                              border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1),width: 0.5))
                            ),
                            padding: EdgeInsets.all(Dimens.size16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '$subjectIndex.$lectureIndex. ${L10nX.getStr.lecture_name_str} $lectureIndex: ${lessonInfo.lectureName}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Gap(Dimens.size10),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _state.checkLecture![subjectIndex][lectureIndex] = !_state.checkLecture![subjectIndex][lectureIndex];
                                    });
                                  },
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      color: Colors.red,
                                    )),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: _state.checkLecture![subjectIndex][lectureIndex]
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.red,
                                            )
                                          : SizedBox(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          : SizedBox(),
    );
  }

  Widget buildStudyOverview() {
    return SingleChildScrollView(
      controller: lessonDetailScrollController,
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
          Text('${_state.courseInfo?.introduction}'),
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
          ListView.builder(
              itemCount: 20,
              controller: lessonDetailScrollController,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return buildWordItem(word: WordInfo(simplified: '吃', traditional: '吃', pinyinTones: 'chī', translationVn: 'ăn', audio: null));
              })
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
                        builder: (BuildContext context, void Function(void Function()) setState) {
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
                                url: word.audio?.link ?? "",
                              ));
                        },
                      )
                    ],
                  ),
                ],
              ),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.remove_red_eye_outlined)),
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
                            buildStudyReviewItem(review: listOfReview[index], index: index),
                            SizedBox(
                              height: 16,
                            )
                          ],
                        );
                      });
                },
              ))
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
                            (likeCheck[index]) ? review.likeCount++ : review.likeCount--;
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
                          color: (dislikeCheck[index]) ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            dislikeCheck[index] = !dislikeCheck[index];
                            (dislikeCheck[index]) ? review.dislikeCount++ : review.dislikeCount--;
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
                              child: buildStudyReviewItemUser(replyCheck: true))))
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
