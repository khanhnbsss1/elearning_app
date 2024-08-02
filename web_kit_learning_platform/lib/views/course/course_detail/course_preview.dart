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
import 'components/course_intro.dart';
import 'components/lecture_list.dart';

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
  double _mainControllerPosition=0;
  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    _mainController.addListener(() {
      _mainControllerPosition= _mainController.position.pixels;
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
            ..add(CourseDetailInitEvent());
        },
        child: Layout(
            title: Text(
              L10nX.getStr.preview_str,
              style: TextStyleConstant.textStyleBlack20w700,
            ),
            padding: EdgeInsets.zero,
            showBackButton: true,
            isScroll: false,
            child: Container(
              decoration: BoxDecoration(color: ColorConst.whiteColor),
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
                            return buildTitle();
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        ListenableBuilder(
                          listenable: showTabBarModel,
                          builder: (BuildContext context, Widget? child) {
                            return Stack(
                              children: [
                                Visibility(
                                  visible: showTabBarModel.position == 0,
                                  child: CourseIntro(),
                                ),
                                Visibility(
                                  visible: showTabBarModel.position == 1,
                                  child: LectureList(),
                                ),
                              ],
                            );
                          },
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
            ))
    );
  }

  Widget buildTitle() {
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
          return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              height: 500,
              child: Stack(
                children: [
                  Container(
                    width: constraints.maxWidth,
                    height: 400,
                    decoration: BoxDecoration(
                      color: ColorConst.blackColor
                    ),
                    child: VideoPlayer(videoPlayerModel: VideoPlayerModel(
                        title: "", 
                        link:"https://www.youtube.com/watch?v=NGl9izvlVKA&list=PL7K6oq4k49igroleELfyc8BCoZAkgjDmZ",// state.courseInfo?.videoPreview ?? ""
                    ),),
                  ),
                  Positioned(
                    bottom: 0,
                    right: (constraints.maxWidth - 800) / 2,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.6,
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
                                        state.courseInfo?.name ?? "",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        color: ColorConst.textColor,
                                      ),
                                      Row(
                                        children: [
                                          StarRating(
                                            color: Colors.yellow,
                                            allowHalfRating: true,
                                            rating: (state.courseInfo?.ratePoint ?? 0).toDouble(),
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
        });
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.5,
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
                    position == value;
                    showTabBarModel.onChangerShowTitle(value);
                    if (value != 0 && _mainControllerPosition> 400) {
                      showTabBarModel.onChangerShowCard(true);
                    }
                   // _mainController.jumpTo(_mainControllerPosition);
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
                ],
              ),
            ),
          ),
        ]);
  }

  int tappedIndex = -1;
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
