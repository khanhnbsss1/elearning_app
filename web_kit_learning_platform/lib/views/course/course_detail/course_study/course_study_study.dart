import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/store/save_file.dart';
import 'package:webkit/base/widgets/common/alert_dialog/loading.export.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/topic/model/topic_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/views/apps/file/file_manager.dart';
import 'package:webkit/views/course/course_detail/bloc/course_detail_bloc.dart';
import 'package:webkit/views/course/course_detail/course_study/subject_item_widget.dart';
import 'package:webkit/views/vocabulary/vocabulary_detail/vocabulary_view_detail.dart';

import '../../../../base/widgets/audio/audio_speaker.dart';
import '../../../../helpers/utils/ui_mixins.dart';
import '../../../../helpers/widgets/my_responsiv.dart';
import '../../../../helpers/widgets/my_spacing.dart';
import '../../../../helpers/widgets/my_text_style.dart';
import '../../../video_player/model/video_model.dart';
import '../../../video_player/video_player.dart';

class CourseStudyStudy extends StatefulWidget {
  const CourseStudyStudy({super.key});

  @override
  State<CourseStudyStudy> createState() => _CourseStudyStudyState();
}

class _CourseStudyStudyState extends State<CourseStudyStudy> with SingleTickerProviderStateMixin, UIMixin {
  ScrollController subjectScrollController = ScrollController();
  ScrollController subjectScrollControllerBar = ScrollController();
  ScrollController studySectionScrollController = ScrollController();
  ScrollController lessonDetailScrollController = ScrollController();
  late CourseDetailState _state;
  late BuildContext _blocContext;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        if(state.blocStatus== AddCourseStatus.onLoading) {
          return Center(
            child: LoadingLogo(loadingType: LoadingType.loadOnPage,),
          );
        }
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return (state.courseInfo?.getListSubjectAndLesson()??[]).isNotEmpty?MyResponsive(
              builder: (buildContext, boxConstraints, myScreenMediaType) {
                return Scaffold(
                  key: _scaffoldKey,
                  appBar: null,
                  backgroundColor: ColorConst.whiteColor,
                  endDrawer: Container(
                    decoration: BoxDecoration(
                      color: ColorConst.whiteColor,
                    ),
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height
                      ),
                      child: buildSubjectList()),
                  body: Padding(
                    padding:  EdgeInsets.only(top: myScreenMediaType.isMobile?0:50),
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: 
                                (_state.blocStatus != AddCourseStatus.onLoadingSelectLesson) ?
                                Scrollbar(
                                  controller: studySectionScrollController,
                                  thickness: 10,
                                  trackVisibility: true,
                                  thumbVisibility: true,
                                  child: SingleChildScrollView(
                                    controller: studySectionScrollController,
                                    scrollDirection: Axis.vertical,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 14.0),
                                      child: Column(
                                        children: [
                                          buildStudySection()
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                    :Center(child: LoadingLogo(loadingType: LoadingType.loadOnPage,)),
                            ),
                            Visibility(
                                visible: boxConstraints.maxWidth > 800,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              color: ColorConst.blackColor,
                                              width: 0.2
                                          ))
                                  ),
                                  padding: EdgeInsets.only(left: 0, top: 0),
                                  constraints: BoxConstraints(
                                      minHeight: MediaQuery.of(context).size.height
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        buildSubjectList(),
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Visibility(
                          visible: boxConstraints.maxWidth < 800,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                _scaffoldKey.currentState!.openEndDrawer();
                                },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorConst.colorIconRed,
                                  borderRadius: BorderRadius.circular(Dimens.size16)
                                ),
                                padding: EdgeInsets.all(Dimens.size16),
                                child: Icon(Icons.list, color: ColorConst.whiteColor,),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ) 
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              buildVideo(),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 16, horizontal: Dimens.size32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildStudyTitle(),
                    buildStudyUI(),
                    buildQuiz(),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildVideo() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        print('rebuild build video');
        return Container(
         // height: 450,
          decoration: BoxDecoration(
              color: Colors.black
          ),
          constraints: BoxConstraints(
            maxHeight: ResponsiveInfo.isPhone()?constraints.maxWidth:MediaQuery.sizeOf(context).height*2/3,
            maxWidth: constraints.maxWidth
          ),
          child: VideoPlayer(
            videoPlayerModel: VideoPlayerModel(
                title: "",
                link: (_state.selectLessonInfo?.link??"").isNotEmpty?(_state.selectLessonInfo?.link??""):
                "https://www.youtube.com/watch?v=RFu43pM2Nbw" 
            ),
            onGetVideoDuration: (duration) {
              if((_state.selectLessonInfo?.videoDuration==null) && duration.inMilliseconds>10)
                {
                  _state.selectLessonInfo?.videoDuration = duration.inMilliseconds~/1000;
                  BlocProvider.of<CourseDetailBloc>(context).add(CourseDetailUpdateInfoSelectLessonEvent(
                      selectLessonInfo: _state.selectLessonInfo!));
                }
            },
            onGetVideoPosition: (duration) {
              print("object");
              if((!(_state.selectLessonInfo?.isFinnish??false)) &&
                  (_state.selectLessonInfo?.videoDuration??0) > 10 &&
                  duration.inMilliseconds/1000 > (_state.selectLessonInfo?.videoDuration??0) - (60*0.5))
                {
                  _state.selectLessonInfo?.isFinnish = true;
                  BlocProvider.of<CourseDetailBloc>(context).add(CourseDetailUpdateFinishLessonEvent(
                      selectLessonInfo: _state.selectLessonInfo!));
                }
            },
          ),
        );

      },
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
              style: TextStyleConstant.textStyleBlack16w600
            ),
          ],
        ),
      ],
    );
  }
  

  Widget buildSubjectList() {
    return Container(
      width: Dimens.size400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: ColorConst.whiteColor
      ),
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
               padding: EdgeInsets.symmetric(horizontal: Dimens.size16, vertical: Dimens.size16),
               child: Text(L10nX.getStr.lesson_list,
                      style: TextStyleConstant.textStyleBlack14w600),
             ),
            Divider(color: ColorConst.blackColor,thickness: 0.1,),
            Scrollbar(
              controller: subjectScrollControllerBar ,
              thickness: 10,
              trackVisibility: true,
              thumbVisibility: true,
              child: ListView.builder(
                controller: subjectScrollController,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                itemCount: (_state.courseInfo?.getListSubjectAndLesson() ?? []).length,
                itemBuilder: (context, subjectIndex) {
                  Subjects subject = (_state.courseInfo?.getListSubjectAndLesson()??[]).elementAt(subjectIndex);
                  return SubjectItemWidget(
                    onFinishLecture: (p0) {
                      
                    },
                    onSelectLesson: (p0) {
                      BlocProvider.of<CourseDetailBloc>(context).add(CourseDetailSelectLessonEvent(selectLessonInfo: p0));
                    },
                    selectLessonInfo: _state.selectLessonInfo,
                    subject: subject,
                    subjectIndex: subjectIndex,
                  );
                },
              ),
            ),
          ],
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
              margin: EdgeInsets.all(0),
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: SingleChildScrollView(
                // controller: subjectScrollController,
                child: ListView.builder(
                  shrinkWrap: true,
                  // controller: subjectScrollController,
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
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: isSelectLesson?ColorConst.greyColor1.withOpacity(0.05): ColorConst.whiteColor,
                              border: Border(bottom: BorderSide(color: ColorConst.blackColor,width: 0.2))
                            ),
                            padding: EdgeInsets.symmetric(vertical: Dimens.size16, horizontal: Dimens.size32),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${subjectIndex+1}.${lectureIndex+1}. ${lessonInfo.lectureName}',
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
                                      color: ColorConst.colorIconGrays,
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

  Widget buildStudyUI() {
    return SingleChildScrollView(
      // controller: lessonDetailScrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "${L10nX.getStr.introduction_str}: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(_state.selectLessonInfo?.note??""),
          SizedBox(
            height: 16,
          ),
          Text(
            "${L10nX.getStr.document_str}: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          InkWell(
            onTap: () {
              if((_state.selectLessonInfo?.docLink??"").isNotEmpty) {
                FileStoreManager().downloadFileFromStream(url: _state.selectLessonInfo?.docLink??"", fileName:  _state.selectLessonInfo?.docName??"");
              }
            },
              child: Text(
                _state.selectLessonInfo?.docName??'',
                style: TextStyleConstant.textStyleBlack13w400.copyWith(color: Colors.blue),)),
          SizedBox(
            height: 16,
          ),
          Text(
            "${L10nX.getStr.vocabulary_str}: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ListView.builder(
              itemCount: (_state.selectLessonInfo?.vocabularies??[]).length,
              // controller: lessonDetailScrollController,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                VocabularyInfo vocabularyInfo = (_state.selectLessonInfo?.vocabularies??[]).elementAt(index);
                return buildWordItem(word: vocabularyInfo);
              })
        ],
      ),
    );
  }

  bool isOnVolume = false;

  Widget buildWordItem({required VocabularyInfo word}) {
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
                    ],
                  ),
                ],
              ),
              Spacer(),
              AudioSpeaker(
                url: word.audioLink ?? "",
                enableProccessBar: true,
              ),
              SizedBox(
                width: 16,
              ),
              InkWell(onTap: () {
                VocabularyViewDetail(selectVocabularyInfo: word,).show(context);
              }, child: Icon(Icons.remove_red_eye_outlined)),
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
    double rating = 5;
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
                      rating: rating,
                      onRatingChanged: (rating) {
                        setState(() {
                          rating = rating;
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
    UserProfile? userInfo = UserManager().getUserProfile();
    return userInfo;
  }

  Widget buildQuiz() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          L10nX.getStr.test_str,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
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
