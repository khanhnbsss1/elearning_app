import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/store/save_file.dart';
import 'package:webkit/base/widgets/common/alert_dialog/loading.export.dart';
import 'package:webkit/base/widgets/widget_common/widget_with_title_common.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';
import 'package:webkit/services/apis/topic/model/topic_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/views/course/course_detail/bloc/course_detail_bloc.dart';
import 'package:webkit/views/course/course_detail/course_study/subject_item_widget.dart';
import 'package:webkit/views/test/test_detail_work/test_work_page.dart';
import 'package:webkit/views/vocabulary/vocabulary_detail/vocabulary_view_detail.dart';
import 'package:http/http.dart';
import '../../../../base/widgets/audio/audio_speaker.dart';
import '../../../../helpers/utils/ui_mixins.dart';
import '../../../../helpers/widgets/my_responsiv.dart';
import '../../../video_player/model/video_model.dart';
import '../../../video_player/video_player.dart';
import 'dart:html';
import 'dart:ui_web' as ui;
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseDetailBloc, CourseDetailState>(
      listener: (context, state) {
        switch (state.blocStatus) {
          case AddCourseStatus.initial:
            break;
          case AddCourseStatus.onSelectionCurrentVideo:
            state.blocStatus = AddCourseStatus.unKnown;
            break;
          default:
            break;
        }
      },
      builder: (BuildContext context, state) {
        _blocContext = context;
        _state = state;
        if (state.blocStatus == AddCourseStatus.onLoading) {
          return Center(
            child: LoadingLogo(
              loadingType: LoadingType.loadOnPage,
            ),
          );
        }
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return (state.courseInfo?.getListSubjectAndLesson() ?? []).isNotEmpty
                ? MyResponsive(
                    builder: (buildContext, boxConstraints, myScreenMediaType) {
                      return Scaffold(
                          key: _scaffoldKey,
                          appBar: null,
                          backgroundColor: ColorConst.whiteColor,
                          endDrawer: Container(
                              decoration: BoxDecoration(
                                color: ColorConst.whiteColor,
                              ),
                              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                              child: buildSubjectAndTestListMobile()),
                          body: Padding(
                            padding: EdgeInsets.only(top: myScreenMediaType.isMobile ? 0 : 50),
                            child: Stack(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: (_state.blocStatus != AddCourseStatus.onLoadingSelectLesson)
                                          ? Scrollbar(
                                              controller: studySectionScrollController,
                                              thickness: 10,
                                              trackVisibility: true,
                                              thumbVisibility: true,
                                              radius: Radius.circular(Dimens.size8),
                                              child: SingleChildScrollView(
                                                controller: studySectionScrollController,
                                                scrollDirection: Axis.vertical,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 14.0),
                                                  child: Column(
                                                    children: [buildStudySection(context)],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Center(
                                              child: LoadingLogo(
                                              loadingType: LoadingType.loadOnPage,
                                            )),
                                    ),
                                    Visibility(
                                        visible: boxConstraints.maxWidth > 800,
                                        child: Container(
                                          decoration: BoxDecoration(border: Border(left: BorderSide(color: ColorConst.blackColor, width: 0.2))),
                                          padding: EdgeInsets.only(left: 0, top: 0),
                                          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                buildSubjectAndTestList(),
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
                                        decoration: BoxDecoration(color: ColorConst.colorIconRed, borderRadius: BorderRadius.circular(Dimens.size16)),
                                        padding: EdgeInsets.all(Dimens.size16),
                                        child: Icon(
                                          Icons.list,
                                          color: ColorConst.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ));
                    },
                  )
                : Center(child: NoData());
          },
        );
      },
    );
  }

  Widget buildStudySection(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: Dimens.size16, horizontal: Dimens.size32),
                child: buildStudyTitle(),
              ),
              buildVideo(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Dimens.size16, horizontal: Dimens.size32),
                child: buildStudyUI(),
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // height: 450,
              decoration: BoxDecoration(color: Colors.black),
              constraints: BoxConstraints(maxHeight: ResponsiveInfo.isPhone() ? constraints.maxWidth : MediaQuery.sizeOf(context).height * 2 / 3, maxWidth: constraints.maxWidth),
              child: VideoPlayer(
                key: Key((_state.selectLessonInfo?.selectVideoInfo?.order ?? '').toString()),
                videoPlayerModel: VideoPlayerModel(title: "", link: (_state.selectLessonInfo?.selectVideoInfo?.videoLink ?? "https://www.youtube.com/watch?v=RFu43pM2Nbw")),
                onGetVideoDuration: (duration) {
                  if ((_state.selectLessonInfo?.videoDuration == null) && duration.inMilliseconds > 10) {
                    _state.selectLessonInfo?.videoDuration = duration.inMilliseconds ~/ 1000;
                    BlocProvider.of<CourseDetailBloc>(context)
                        .add(CourseDetailUpdateInfoSelectLessonEvent(selectLessonInfo: _state.selectLessonInfo!, selectVideoInfo: _state.selectLessonInfo!.selectVideoInfo!));
                  }
                },
                onGetVideoPosition: (duration) {
                  print("object");
                  if ((!(_state.selectLessonInfo?.isFinnish ?? false)) &&
                      (_state.selectLessonInfo?.videoDuration ?? 0) > 10 &&
                      duration.inMilliseconds / 1000 > (_state.selectLessonInfo?.videoDuration ?? 0) - (60 * 0.5)) {
                    _state.selectLessonInfo?.isFinnish = true;
                    BlocProvider.of<CourseDetailBloc>(context)
                        .add(CourseDetailUpdateFinishLessonEvent(selectLessonInfo: _state.selectLessonInfo!, selectVideoInfo: _state.selectLessonInfo!.selectVideoInfo!));
                  }
                },
              ),
            ),
            Gap(Dimens.size16),
            Visibility(
              visible: (_state.selectLessonInfo?.videoInfos?.link ?? []).length > 1,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Dimens.size16, horizontal: Dimens.size32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${L10nX.getStr.watching_str.toString()}: ${_state.selectLessonInfo?.selectVideoInfo?.videoTitle}',
                      style: TextStyleConstant.textStyleBlack16w600,
                      textAlign: TextAlign.start,
                    ),
                    Gap(Dimens.size8),
                    SizedBox(
                        height: Dimens.size100,
                        child: Center(
                          child: ListView.builder(
                            itemCount: (_state.selectLessonInfo?.videoInfos?.link ?? []).length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              VideoInfo videoInfo = (_state.selectLessonInfo?.videoInfos?.link ?? []).elementAt(index);
                              bool isSelect = videoInfo.order == _state.selectLessonInfo?.selectVideoInfo?.order;
                              String? thumb = getYoutubeThumbnail(videoUrl: videoInfo.videoLink ?? "");
                              return InkWell(
                                onTap: () {
                                  if (!isSelect) {
                                    BlocProvider.of<CourseDetailBloc>(context).add(CourseDetailOnSelectCurrentVideoEvent(selectLessonInfo: _state.selectLessonInfo!, selectVideoInfo: videoInfo));
                                  } else {
                                    ToastUtils.showToast("Bạn đang xem video bài giảng này");
                                  }
                                },
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimens.size8,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimens.size16),
                                              border: Border.all(color: ColorConst.colorIconGrays, width: 0.5),
                                              color: ColorConst.blackColor.withOpacity(isSelect ? 0.8 : 1)),
                                          width: Dimens.size150,
                                          height: Dimens.size100,
                                          padding: EdgeInsets.all(Dimens.size8),
                                          child: (thumb ?? '').isNotEmpty
                                              ? ImageManager().getImageByUrl(
                                                  thumb ?? "",
                                                  errorBuilder: Icon(
                                                    Icons.video_library_outlined,
                                                    color: ColorConst.whiteColor,
                                                    size: Dimens.size40,
                                                  ),
                                                )
                                              : Icon(
                                                  Icons.video_library_outlined,
                                                  color: ColorConst.whiteColor,
                                                  size: Dimens.size40,
                                                ),
                                        ),
                                        Visibility(
                                          visible: isSelect,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              L10nX.getStr.watching_str,
                                              style: TextStyleConstant.textStyleBlack13w400.copyWith(color: ColorConst.whiteColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              );
                            },
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Visibility(
                visible: (_state.selectLessonInfo?.videoInfos?.link ?? []).length > 1,
                child: Divider(
                  color: ColorConst.colorIconGrays,
                  thickness: 0.5,
                )),
          ],
        );
      },
    );
  }

  String? getYoutubeThumbnail({required String videoUrl}) {
    final Uri? uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return null;
    }

    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }

  Widget buildStudyTitle() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(Dimens.size16),
            Text('Bài giảng: ${_state.selectLessonInfo?.lectureName!}', style: TextStyleConstant.textStyleBlack16w600),
          ],
        ),
      ],
    );
  }

  Widget buildSubjectAndTestList() {
    return Container(
      width: Dimens.size400,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: ColorConst.whiteColor),
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.size16, vertical: Dimens.size16),
                  child: Text("I. ${L10nX.getStr.lesson_list}", textAlign: TextAlign.start, style: TextStyleConstant.textStyleBlack14w600),
                ),
                Divider(
                  color: ColorConst.blackColor,
                  thickness: 0.1,
                ),
                Scrollbar(
                  controller: subjectScrollControllerBar,
                  thickness: 10,
                  trackVisibility: true,
                  thumbVisibility: true,
                  child: ListView.builder(
                    controller: subjectScrollControllerBar,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    itemCount: (_state.courseInfo?.getListSubjectAndLesson() ?? []).length,
                    itemBuilder: (context, subjectIndex) {
                      Subjects subject = (_state.courseInfo?.getListSubjectAndLesson() ?? []).elementAt(subjectIndex);
                      return SubjectItemWidget(
                        onFinishLecture: (p0) {},
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
                Gap(
                  Dimens.size8,
                ),
              ],
            ),
            TestItemWidget(
              testInfos: [
                TestInfo(id: _state.courseInfo?.testId, courseId: _state.courseInfo?.id, name: _state.courseInfo?.testName ?? ""),
              ],
              subjectIndex: 1,
              onSelectTest: (testInfo) {},
            )
          ],
        ),
      ),
    );
  }

  Widget buildSubjectAndTestListMobile({bool? isOnDrawer}) {
    return Container(
      width: Dimens.size400,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: ColorConst.whiteColor),
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.size16, vertical: Dimens.size16),
              child: Text(L10nX.getStr.lesson_list, style: TextStyleConstant.textStyleBlack14w600),
            ),
            Divider(
              color: ColorConst.blackColor,
              thickness: 0.1,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Scrollbar(
                      //controller: subjectScrollControllerBar ,
                      thickness: 5,
                      trackVisibility: true,
                      thumbVisibility: true,
                      radius: Radius.circular(Dimens.size5),
                      child: ListView.builder(
                        controller: subjectScrollControllerBar,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.zero,
                        itemCount: (_state.courseInfo?.getListSubjectAndLesson() ?? []).length,
                        itemBuilder: (context, subjectIndex) {
                          Subjects subject = (_state.courseInfo?.getListSubjectAndLesson() ?? []).elementAt(subjectIndex);
                          return SubjectItemWidget(
                            onFinishLecture: (p0) {},
                            onSelectLesson: (p0) {
                              BlocProvider.of<CourseDetailBloc>(context).add(CourseDetailSelectLessonEvent(selectLessonInfo: p0));
                            },
                            selectLessonInfo: _state.selectLessonInfo,
                            subject: subject,
                            subjectIndex: subjectIndex,
                            subjectScrollController: subjectScrollControllerBar,
                          );
                        },
                      ),
                    ),
                  ),
                  Gap(
                    Dimens.size8,
                  ),
                  TestItemWidget(
                    testInfos: [
                      TestInfo(id: _state.courseInfo?.testId, courseId: _state.courseInfo?.id, name: _state.courseInfo?.testName ?? ""),
                    ],
                    subjectIndex: 1,
                    onSelectTest: (testInfo) {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStudyUI() {
    return SingleChildScrollView(
        // controller: lessonDetailScrollController,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Gap(Dimens.size30),
      WidgetWithColumnTitleCommon(
        title: "- ${L10nX.getStr.introduction_str}: ",
        childPadding: EdgeInsets.symmetric(horizontal: Dimens.size24),
        titleStyle: TextStyleConstant.textStyleBlack13w600.copyWith(color: ColorConst.mainColor),
        child: Text(
          _state.selectLessonInfo?.note ?? "",
          style: TextStyleConstant.textStyleBlack13w400,
        ),
      ),
      Gap(Dimens.size16),
      Visibility(
        visible: (_state.selectLessonInfo?.docLink ?? '').isNotEmpty,
        child: WidgetWithColumnTitleCommon(
          title: "- ${L10nX.getStr.document_str}: ",
          childPadding: EdgeInsets.symmetric(horizontal: Dimens.size24),
          titleStyle: TextStyleConstant.textStyleBlack13w600.copyWith(color: ColorConst.mainColor),
          child: InkWell(
              onTap: () {
                if ((_state.selectLessonInfo?.docLink ?? "").isNotEmpty) {
                  FileStoreManager().downloadFileFromStream(url: _state.selectLessonInfo?.docLink ?? "", fileName: _state.selectLessonInfo?.docName ?? "");
                }
              },
              child: Text(
                _state.selectLessonInfo?.docName ?? '',
                style: TextStyleConstant.textStyleBlack13w400.copyWith(color: Colors.blue),
              )),
        ),
      ),
      Gap(Dimens.size16),
      Visibility(
        visible: (_state.selectLessonInfo?.content ?? '').isNotEmpty,
        child: WidgetWithColumnTitleCommon(
          title: "- ${L10nX.getStr.content_str}: ",
          titleStyle: TextStyleConstant.textStyleBlack13w600.copyWith(color: ColorConst.mainColor),
          childPadding: EdgeInsets.symmetric(horizontal: Dimens.size24, vertical: Dimens.size16),
          child: buildLessonContent(_state.selectLessonInfo),
        ),
      ),
      Gap(Dimens.size16),
      Visibility(
        visible: (_state.selectLessonInfo?.vocabularies ?? []).isNotEmpty,
        child: WidgetWithColumnTitleCommon(
          title: "- ${L10nX.getStr.vocabulary_str}: ",
          childPadding: EdgeInsets.symmetric(horizontal: Dimens.size24),
          titleStyle: TextStyleConstant.textStyleBlack13w600.copyWith(color: ColorConst.mainColor),
          child: ListView.builder(
              itemCount: (_state.selectLessonInfo?.vocabularies ?? []).length,
              // controller: lessonDetailScrollController,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                VocabularyInfo vocabularyInfo = (_state.selectLessonInfo?.vocabularies ?? []).elementAt(index);
                return buildWordItem(word: vocabularyInfo);
              }),
        ),
      ),
      Visibility(
          visible: _state.selectLessonInfo?.testId != null,
          child: WidgetWithColumnTitleCommon(
            title: "- ${L10nX.getStr.test_str}:",
            titleStyle: TextStyleConstant.textStyleBlack13w600.copyWith(color: ColorConst.mainColor),
            childPadding: EdgeInsets.symmetric(horizontal: Dimens.size24),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.size16),
                  child: InkWell(
                      onTap: () {
                        if (_state.selectLessonInfo?.testId != null) {
                          TestWorkPage(
                            testInfo: TestInfo(id: _state.selectLessonInfo?.testId, lectureId: _state.selectLessonInfo?.id, name: _state.selectLessonInfo?.testName ?? ''),
                          ).show(context);
                        }
                      },
                      child: Text(
                        _state.selectLessonInfo?.testName ?? '',
                        style: TextStyleConstant.textStyleBlack13w400,
                      )),
                ),
                ActionButton1(
                  onTap: () {
                    TestWorkPage(
                      testInfo: TestInfo(id: _state.selectLessonInfo?.testId, lectureId: _state.selectLessonInfo?.id, name: _state.selectLessonInfo?.testName ?? ''),
                    ).show(context);
                  },
                  text: L10nX.getStr.begin_start_test,
                )
              ],
            ),
          ))
    ]));
  }

  bool isOnVolume = false;

  Widget buildWordItem({required VocabularyInfo word}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('$index.'),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${word.pinyinTones}'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('$index.'),
                        Expanded(child: Text('${word.simplified} : ${word.translationVn}')),
                        Gap(Dimens.size12),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(Dimens.size12),
              AudioSpeaker(
                url: word.audioLink ?? "",
                enableProccessBar: true,
              ),
              Gap(Dimens.size12),
              InkWell(
                  onTap: () {
                    VocabularyViewDetail(
                      selectVocabularyInfo: word,
                    ).show(context);
                  },
                  child: Icon(Icons.remove_red_eye_outlined)),
              Gap(Dimens.size12),
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

  Future<UserProfile?> getProfile() async {
    UserProfile? userInfo = UserManager().getUserProfile();
    return userInfo;
  }

  Widget buildLessonContent(LessonInfo? selectLessonInfo) {
    String cmd = """http://mozilla.github.io/pdf.js/web/viewer.html?
                  file= ${selectLessonInfo?.content ?? ''}
                  #toolbar=0&navpanes=0&scrollbar=0&statusbar=0&messages=0""";
    String cmd1 = """${selectLessonInfo?.content ?? ''}#toolbar=0&navpanes=0&scrollbar=0"
    type="application/pdf"
    frameBorder="0"
    scrolling="auto"
    height="100%"
    width="100%""";
    return (selectLessonInfo?.content ?? '').isNotEmpty
        ? Container(
            height: Dimens.size600,
            decoration: BoxDecoration(
              border: Border.all(color: ColorConst.colorIconGrays, width: 0.5),
              // borderRadius: BorderRadius.circular(Dimens.size16)
            ),
            clipBehavior: Clip.hardEdge,
            child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
              ui.platformViewRegistry.registerViewFactory(
                  "lesson_content_${(selectLessonInfo?.id??"").toString()}",
                      (int viewId) =>EmbedElement()
                    ..width = '640'
                    ..height = '360'
                    ..src = cmd1);
              return HtmlElementView(
                viewType: "lesson_content_${(selectLessonInfo?.id??"").toString()}",
              );
            }))
        : SizedBox();
  }

  Future<Uint8List?> getContentData(String url) async {
    Response res = await get(
      Uri.parse(url),
    );
    if (res.statusCode == 200) {
      return res.bodyBytes;
    }
    return null;
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
