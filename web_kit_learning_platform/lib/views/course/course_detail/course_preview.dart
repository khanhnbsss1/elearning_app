import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/views/layouts/layout.dart';
import 'package:webkit/views/video_player/model/video_model.dart';
import 'package:webkit/views/video_player/video_player.dart';

import '../../../helpers/utils/ui_mixins.dart';
import '../../../services/apis/course/course_detail/models/course_detail_model.dart';
import 'bloc/course_detail_bloc.dart';
import 'components/course_intro.dart';

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
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return CourseDetailBloc(CourseDetailState(courseInfo: widget.courseInfo))..add(CourseDetailInitEvent());
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

              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                  children: [
                  SingleChildScrollView(
                  controller: _mainController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ListenableBuilder(
                          listenable: showTabBarModel,
                          builder: (BuildContext context, Widget? child) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildTitle(),
                            );
                          },
                        ),
                        CourseIntro(),
                      ],
                    ),
                  ),
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
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  //height: 420,
                  decoration: BoxDecoration(
                      color: Colors.black
                  ),
                  constraints: BoxConstraints(
                      maxHeight: ResponsiveInfo.isPhone()?constraints.maxWidth:MediaQuery.sizeOf(context).height*3/4,
                      maxWidth: constraints.maxWidth
                  ),
                  child: VideoPlayer(videoPlayerModel: VideoPlayerModel(
                      title: "", 
                      // link:"https://www.youtube.com/watch?v=NGl9izvlVKA&list=PL7K6oq4k49igroleELfyc8BCoZAkgjDmZ",
                    link: state.courseInfo?.videoPreview ?? "",
                  ),),
                ),
              ],
            );
          },
          );
        });
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
