import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/views/layouts/layout.dart';
import 'package:webkit/views/video_player/model/video_model.dart';
import 'package:webkit/views/video_player/video_player.dart';

import '../../../helpers/utils/ui_mixins.dart';
import '../../../services/apis/course/course_detail/models/course_detail_model.dart';
import 'bloc/course_detail_bloc.dart';

class CoursePreview extends StatefulWidget {
  CourseInfo courseInfo;

  CoursePreview({
    super.key,
    required this.courseInfo,
  });

  void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => this,
    );
  }

  @override
  State<CoursePreview> createState() => _CourseStudyState();
}

class _CourseStudyState extends State<CoursePreview> with SingleTickerProviderStateMixin, UIMixin {
  late TabController tabController;

  ShowTabBarModel showTabBarModel = ShowTabBarModel();

  int position = 0;

  final ScrollController _mainController = ScrollController();

  late CourseDetailState _state;
  
  @override
  void initState() {
    super.initState();
   
    tabController = TabController(length: 3, vsync: this);
    _mainController.addListener(() {
      if (_mainController.offset > 400) {
        if (showTabBarModel.showTabBar == false) {
          showTabBarModel.onChangerShowCard(true);
        }
      } else {
        if (showTabBarModel.showTabBar == true) {
          showTabBarModel.onChangerShowCard(false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return CourseDetailBloc(CourseDetailState(courseInfo: widget.courseInfo))
            ..add(CourseDetailnitEvent());
        },
        child: BlocConsumer<CourseDetailBloc, CourseDetailState>(
            listener: (context, state) {
              switch (state.blocStatus) {
                case AddCourseStatus.initial:
                  
                  break;
                default:
                  break;
              }
            },
            builder: (BuildContext context, state) {
              _state = state;
              return Layout(
                  title: Text(
                    L10nX.getStr.preview_str,
                    style: TextStyleConstant.textStyleBlack20w700,
                  ),
                  padding: EdgeInsets.zero,
                  showBackButton: true,
                  isScroll: false,
                  child: Container(
                    decoration: BoxDecoration(color: ColorConst.whiteColor),
                    child: Padding(
                      padding: EdgeInsets.only(top: Dimens.size50, bottom: Dimens.size16, left: Dimens.size16, right: Dimens.size16),
                      child: Stack(children: [
                        SingleChildScrollView(
                          controller: _mainController,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                ListenableBuilder(
                                  listenable: showTabBarModel,
                                  builder: (BuildContext context, Widget? child) {
                                    return Visibility(
                                      visible: showTabBarModel.position == 0,
                                      child: buildTitle(),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Stack(
                                  children: [
                                    Visibility(
                                      visible: tabController.index == 0,
                                      child: buildInfo(),
                                    ),
                                    Visibility(
                                      visible: tabController.index == 1,
                                      child: buildLectureList(),
                                    ),
                                    Visibility(
                                      visible: tabController.index == 2,
                                      child: Text("It's sunny here"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListenableBuilder(
                          listenable: showTabBarModel,
                          builder: (BuildContext context, Widget? child) {
                            return Visibility(
                              visible: showTabBarModel.showTabBar,
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: EdgeInsets.all(Dimens.size16),
                                    child: buildTabBar(),
                                  )),
                            );
                          },
                        ),
                      ]),
                    ),
                  ));
            }));
  }

  Widget buildTitle() {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) { 
      return SizedBox(
        height: 450,
        child: Stack(
          children: [
            SizedBox(
              width: constraints.maxWidth,
              height: 400,
              child: VideoPlayer(videoPlayerModel: VideoPlayerModel(title: "", link: _state.courseInfo?.videoPreview??""),),
            ),
            Positioned(
              bottom: 0,
              right: (constraints.maxWidth -800)/2,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.6,
                      constraints: BoxConstraints(
                        maxWidth: 800,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.titleLarge(
                                  _state.courseInfo?.name??"",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  color: ColorConst.textColor,
                                ),
                                Row(
                                  children: [
                                    StarRating(
                                      color: Colors.yellow,
                                      allowHalfRating: true,
                                      rating: (_state.courseInfo?.ratePoint??0).toDouble(),
                                    ),
                                    // SizedBox(
                                    //   width: 4,
                                    // ),
                                    // Text(
                                    //     '${_state.courseInfo?.ratePoint!.toDouble()} trên 5')
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          ActionButton1(
                            text: 'Đăng ký ngay',
                          ),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                    buildTabBar()
                  ],
                ),
              ),
            )
          ],
        ),
      );
    },
    );
  }

  Widget buildTabBar() {
    TextStyleConstant.textStyleBlack15w700.copyWith(color: (position == 0 ? ColorConst.textColorSelectTabBar : ColorConst.subtext));
    return Column
      (
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
        elevation: 5,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          constraints: BoxConstraints(
            maxWidth: 800,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: TabBar(
            indicatorColor: ColorConst.mainColor,
            dividerColor: Colors.transparent,
            labelColor: ColorConst.mainColor,
            indicator: BoxDecoration(border: Border(bottom: BorderSide(color: ColorConst.mainColor))),
            splashBorderRadius: BorderRadius.circular(12),
            overlayColor: WidgetStateProperty.all(Colors.black.withOpacity(0.1)),
            dividerHeight: 0,
            controller: tabController,
            onTap: (value) {
              setState(() {
                position == value;
                showTabBarModel.onChangerShowTitle(value);
              });
            },
            tabs: [
              Tab(
                child: Text(
                  L10nX.getStr.introduction_str,
                  style: TextStyleConstant.textStyleBlack14w400,
                ),
              ),
              Tab(
                child: Text(
                  L10nX.getStr.content_str,
                  style: TextStyleConstant.textStyleBlack14w400,
                ),
              ),
              Tab(
                child: Text(
                  L10nX.getStr.quick_links,
                  style: TextStyleConstant.textStyleBlack14w400,
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget buildInfo() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Expanded(flex: 6, child: Align(alignment: Alignment.topLeft, child: buildInfoBox())),
              Expanded(flex: 4, child: Align(alignment: Alignment.centerLeft, child: buildInfoCard())),
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
// SizedBox(
//   height: 16,
// ),
// buildInfoRelatedCourse(),
          ],
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
        Text('${_state.courseInfo?.introduction}'),
      ],
    );
  }

  List<bool> showLecture = List.filled(3, false, growable: true);
  int tappedIndex = -1;

  Widget buildLectureList() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Danh sách bài học: ',
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
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
                                (!showLecture[index]) ? Icon(Icons.add) : Icon(Icons.horizontal_rule_outlined),
                                SizedBox(
                                  width: 4,
                                ),
                                Text('Subject $index: Subject $index name'),
                                Spacer(),
                                Checkbox(
                                  value: false,
                                  onChanged: (bool? value) {
                                    value = !value!;
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          showLecture[index] = !showLecture[index];
                        });
                      },
                    ),
                    AnimatedSize(
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(milliseconds: 200),
                      child: showLecture[index]
                          ? Container(
                              margin: EdgeInsets.all(16),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 3,
                                itemBuilder: (context, lectureIndex) {
                                  return Container(
                                    margin: EdgeInsets.only(left: 32, top: 16, bottom: 16),
                                    child: Text('Lecture $index: Lecture $lectureIndex name'),
                                  );
                                },
                              ),
                            )
                          : SizedBox(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
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
          child: (_state.courseInfo?.infoResult == null)
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: _state.courseObject?.length,
                  itemBuilder: (context, index) => Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Text((_state.courseObject??[])[index])
                        ],
                      ))
              : Text('${_state.courseInfo?.infoResult}'),
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
          child: (_state.courseInfo?.infoResult == null)
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: _state.courseResult?.length,
                  itemBuilder: (context, index) => Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Text((_state.courseResult??[])[index])
                        ],
                      ))
              : Text('${_state.courseInfo?.infoResult}'),
        ),
      ],
    );
  }

  Widget buildInfoBoxTag() {
    final tags = _state.courseInfo?.tags;
    try {
      print(_state.courseInfo?.lectures?.first);
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

// Widget buildInfoRelatedCourse() {
//
// }

  Widget buildInfoCard() {
    return Column(
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
                        (_state.courseInfo?.videoPreview??'').isEmpty ? 'assets/deshboard/adventure/adventure5.png' : _state.courseInfo?.videoPreview??"",
                        fit: BoxFit.fill,
                      )),
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
                            Text(_state.courseInfo?.gradeName ?? '-'),
                            SizedBox(
                              height: 8,
                            ),
                            Text(_state.courseInfo?.producerName ?? '-'),
                            SizedBox(
                              height: 8,
                            ),
                            Text(_state.courseInfo?.durian ?? '-'),
                            SizedBox(
                              height: 8,
                            ),
                            Text('${_state.courseInfo?.totalSubjects} chủ đề, ${_state.courseInfo?.totalLectures} bài học'),
                            SizedBox(
                              height: 8,
                            ),
                            Text('${_state.courseInfo?.isStandard ?? '0'}'),
                            SizedBox(
                              height: 8,
                            ),
                            Text('${_state.courseInfo?.id ?? '0'}'),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black.withOpacity(0.1))),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '${_state.courseInfo?.payment??0 / 0.8} VND',
                            style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.black45, fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${_state.courseInfo?.payment!} VND',
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
    );
  }

  Widget buildStudy() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Expanded(flex: 6, child: Align(alignment: Alignment.topLeft, child: buildStudySection())),
              Expanded(flex: 4, child: Align(alignment: Alignment.topCenter, child: buildLectureList())),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStudySection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoBoxIntroduction(),
          ],
        ),
      ),
    );
  }
}

class ShowTabBarModel with ChangeNotifier {
  bool _showCard = false;
  int _position = 0;
  bool get showTabBar => _showCard;
  int get position => _position;

  void onChangerShowCard(bool showCard) {
    _showCard = showCard;
    notifyListeners();
  }

  void onChangerShowTitle(int position) {
    _position = position;
    notifyListeners();
  }
}
