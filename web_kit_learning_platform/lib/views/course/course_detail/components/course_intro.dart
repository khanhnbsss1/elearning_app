import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/base/widgets/popup_confirm/confirm_popup_page.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/services/apis/payment/unlock_course_api.dart';
import 'package:webkit/services/apis/user/course/register_course_api.dart';
import 'package:webkit/views/course/course_detail/bloc/course_detail_bloc.dart';
import 'package:webkit/views/course/course_detail/components/review_page.dart';

import '../../../../helpers/widgets/my_text.dart';
import '../course_preview.dart';
import '../course_study/course_study.dart';
import 'lecture_list.dart';

class CourseIntro extends StatefulWidget {
  @override
  State<CourseIntro> createState() => _CourseIntroState();
}

class _CourseIntroState extends State<CourseIntro> with TickerProviderStateMixin, UIMixin {
  late CourseDetailState _state;

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return buildInfo(context);
  }

  int position = 0;

  double _mainControllerPosition = 0;
  late TabController tabController;
  final ScrollController _mainController = ScrollController();
  ShowTabBarModel showTabBarModel = ShowTabBarModel();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    _mainController.addListener(() {
      _mainControllerPosition = _mainController.position.pixels;
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

  Widget buildInfo(BuildContext context) {
    return MyResponsive(
      builder: (buildContext, constraints, myScreenMediaType) {
        return SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: constraints.maxWidth > 800
                ? Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: buildInfoBox(context, constraints)),
                SizedBox(width: Dimens.size400, child: buildInfoCard()),
              ],
            )
                : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [buildInfoBox(context, constraints), buildInfoCard()],
            ),
          ),
        );
      },
    );
  }

  Widget buildInfoBox(BuildContext context, BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocConsumer<CourseDetailBloc, CourseDetailState>(
              buildWhen: (previous, current) {
                return current.blocStatus != AddCourseStatus.onChangeRating &&
                    current.blocStatus != AddCourseStatus.getRatingList &&
                    current.blocStatus != AddCourseStatus.onSubmitRating;
              },
              listener: (context, state) {

                switch (state.blocStatus) {
                  case AddCourseStatus.initial:
                    break;
                  default:
                    break;
                }
              }, builder: (BuildContext context, state) {
            _state = state;
            return            constraints.maxWidth > 450
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: MyText.titleLarge(
                                state.courseInfo?.name ?? "",
                                style: TextStyleConstant.titleTextColorOnBackgroundColorStyle16w600.copyWith(
                                  fontSize: Dimens.size30,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.visible,
                                color: ColorConst.textColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            StarRating(
                              color: Colors.yellow,
                              allowHalfRating: true,
                              rating: (state.courseInfo?.rating ?? 0).toDouble(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ActionButton1(
                  text: (state.courseInfo?.isPayment ?? false) ? L10nX.getStr.lets_study : L10nX.getStr.register_now,
                  onTap: () {
                    registeredCourse(state: state);
                  },
                ),
              ],
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: MyText.titleLarge(
                              state.courseInfo?.name ?? "",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              color: ColorConst.textColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          StarRating(
                            color: Colors.yellow,
                            allowHalfRating: true,
                            rating: (state.courseInfo?.rating ?? 0).toDouble(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                /*ActionButton1(
                      text: L10nX.getStr.register_now,
                    ),*/
                ActionButton1(
                  text: (state.courseInfo?.isPayment ?? false) ? L10nX.getStr.lets_study : L10nX.getStr.register_now,
                  onTap: () {
                    registeredCourse(state: state);
                  },
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            );
          }),

          buildTabBar(),
          ListenableBuilder(
            listenable: showTabBarModel,
            builder: (BuildContext context, Widget? child) {
              return Stack(
                children: [
                  Visibility(
                      visible: showTabBarModel.position == 0,
                      child:
                      BlocConsumer<CourseDetailBloc, CourseDetailState>(
                          buildWhen: (previous, current) {
                            return current.blocStatus != AddCourseStatus.onChangeRating &&
                                current.blocStatus != AddCourseStatus.getRatingList &&
                                current.blocStatus != AddCourseStatus.onSubmitRating;
                          },
                          listener: (context, state) {

                            switch (state.blocStatus) {
                              case AddCourseStatus.initial:
                                break;
                              default:
                                break;
                            }
                          }, builder: (BuildContext context, state) {
                        _state = state;
                        return  Column(
                          children: [
                            buildInfoBoxIntroduction(),
                            SizedBox(
                              height: 16,
                            ),
                            Divider(
                              color: ColorConst.dividerColor,
                            ),
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
                        );
                      })
                     ),
                  Visibility(
                    visible: showTabBarModel.position == 1,
                    child: LectureList(),
                  ),
                  Visibility(
                    visible: showTabBarModel.position == 2,
                    child: ReviewPage(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildTabBar() {
    TextStyleConstant.textStyleBlack15w700.copyWith(color: (position == 0 ? ColorConst.textColorSelectTabBar : ColorConst.subtext));
    return Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
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
              position == value;
              showTabBarModel.onChangerShowTitle(value);
              if (value != 0 && _mainControllerPosition > 400) {
                showTabBarModel.onChangerShowCard(true);
              }
              // _mainController.jumpTo(_mainControllerPosition);
            },
            tabs: [
              Tab(
                child: Text(
                  L10nX.getStr.introduction_str,
                  style: TextStyleConstant.textStyleBlack16w500,
                ),
              ),
              Tab(
                child: Text(
                  L10nX.getStr.content_str,
                  style: TextStyleConstant.textStyleBlack16w500,
                ),
              ),
              Tab(
                child: Text(
                  L10nX.getStr.review_str,
                  style: TextStyleConstant.textStyleBlack16w500,
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget buildInfoBoxIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16,
        ),
        Text(_state.courseInfo?.introduction ?? "hello", style: TextStyleConstant.textStyleBlack14w400,),
      ],
    );
  }

  Widget buildInfoBoxInfoObj() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Khóa học này dành cho: ',
          style: TextStyleConstant.textStyleBlack15w500.copyWith(color: ColorConst.mainColor),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: (_state.courseObject ?? []).isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  controller: controller,
                  itemCount: _state.courseObject?.length,
                  itemBuilder: (context, index) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.red,
                            size: Dimens.size20,
                          ),
                          SizedBox(
                            width: Dimens.size24,
                          ),
                          Expanded(
                              child: Text(
                            (_state.courseObject ?? [])[index],
                            maxLines: 5,
                            style:TextStyleConstant.textStyleBlack14w400,
                          ))
                        ],
                      ))
              : Text('${_state.courseInfo?.getListInfoObj()}', style: TextStyleConstant.textStyleBlack14w400,),
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
          style: TextStyleConstant.textStyleBlack15w500.copyWith(color: ColorConst.mainColor),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: (_state.courseResult ?? []).isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  controller: controller,
                  itemCount: _state.courseResult?.length,
                  itemBuilder: (context, index) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.red,
                            size: Dimens.size20,
                          ),
                          SizedBox(
                            width: Dimens.size24,
                          ),
                          Expanded(
                              child: Text(
                            (_state.courseResult ?? [])[index],
                            maxLines: 5,
                                style: TextStyleConstant.textStyleBlack14w400,
                          ))
                        ],
                      ))
              : Text('${_state.courseInfo?.getListInfoResult()}',style:  TextStyleConstant.textStyleBlack14w400),
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
      return Text(
        "${L10nX.getStr.tags}: No tags",
        style: TextStyleConstant.textStyleBlack15w500,
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "${L10nX.getStr.tags}:   ", 
              style: TextStyleConstant.textStyleBlack15w500
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
                        fontSize: Dimens.size16
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
    return  BlocConsumer<CourseDetailBloc, CourseDetailState>(
        buildWhen: (previous, current) {
          return current.blocStatus != AddCourseStatus.onChangeRating &&
              current.blocStatus != AddCourseStatus.getRatingList &&
              current.blocStatus != AddCourseStatus.onSubmitRating;
        },
        listener: (context, state) {

          switch (state.blocStatus) {
            case AddCourseStatus.initial:
              break;
            default:
              break;
          }
        }, builder: (BuildContext context, state) {
      _state = state;
      return Column(
        children: [
          Card(
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: ImageManager().getImageByUrl(
                          (_state.courseInfo?.image ?? '').isEmpty ? 'assets/deshboard/adventure/adventure5.png' : _state.courseInfo?.image ?? "",
                          boxFit: BoxFit.fill,
                          errorBuilder: ImageManager().getImageByUrl('assets/deshboard/adventure/adventure5.png', boxFit: BoxFit.fill, errorBuilder: SizedBox()),
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('${L10nX.getStr.category_str}:', style: TextStyleConstant.textStyleBlack15w400,),
                              SizedBox(
                                height: Dimens.size8,
                              ),
                              Text('${L10nX.getStr.author_str}: ',style: TextStyleConstant.textStyleBlack15w400,),
                              SizedBox(
                                height: Dimens.size8,
                              ),
                              Text('${L10nX.getStr.duration_str}: ',style: TextStyleConstant.textStyleBlack15w400,),
                              SizedBox(
                                height: Dimens.size8,
                              ),
                              Text('${L10nX.getStr.content_str}: ',style: TextStyleConstant.textStyleBlack15w400,),
                            ],
                          ),
                          SizedBox(
                            width: Dimens.size30,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(_state.courseInfo?.gradeName ?? '-',style: TextStyleConstant.textStyleBlack15w400,),
                                SizedBox(
                                  height: Dimens.size8,
                                ),
                                Text(_state.courseInfo?.producerName ?? '-',style: TextStyleConstant.textStyleBlack15w400,),
                                SizedBox(
                                  height: Dimens.size8,
                                ),
                                Text(_state.courseInfo?.durian ?? '-',style: TextStyleConstant.textStyleBlack15w400,),
                                SizedBox(
                                  height: Dimens.size8,
                                ),
                                Text(
                                  '${_state.courseInfo?.totalSubjects} ${L10nX.getStr.subject_str}, ${_state.courseInfo?.totalLectures} ${L10nX.getStr.lesson_str}'
                                  ,style: TextStyleConstant.textStyleBlack15w400,),
                                SizedBox(
                                  height: Dimens.size8,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.black.withOpacity(0.1))),
                      constraints: BoxConstraints(minWidth: Dimens.size250),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              '${_state.courseInfo?.price ?? 0 / 0.8} VND',
                              style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.black45, fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '${_state.courseInfo?.price!} VND',
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
                              text: (state.courseInfo?.isPayment ?? false) ? L10nX.getStr.lets_study : L10nX.getStr.register_now,
                              onTap: () {
                                registeredCourse(state: state);
                              },
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
    });
    
  }

  void registeredCourse({required CourseDetailState state}) {
    if (state.courseInfo?.isPayment ?? false) {
      Navigator.of(context).pop();
      CourseStudy1(
        courseInfo: state.courseInfo!,
      ).show(context);
    } else {
      ConfirmPopupPage(
        title: "${L10nX.getStr.register} ${L10nX.getStr.course_str.toLowerCase()}",
        content: L10nX.getStr.you_are_ready_register_this_course,
        onAccept: () async {
          MonitorLoading().showLoading("");
          RegisterCourseApi registerCourseApi = RegisterCourseApi(courseId: state.courseInfo!.id!);
          dynamic data = await registerCourseApi.call();
          MonitorLoading().dismiss();
          if (data.runtimeType == String && (data as String).isEmpty) {
            ConfirmPopupPage(
              title: L10nX.getStr.string_notify,
              content: (state.courseInfo?.price ?? 0) > 0 ? "Yêu cầu đăng ký đã được gửi đến quản trị viên và sẽ được xử lý sớm !" : "Đăng ký thành công, bây giờ bạn có thế vào học ngay bây giờ ",
              onAccept: () async {
                Navigator.of(context).pop();
                if ((state.courseInfo?.price ?? 0) <= 0) {
                  CourseStudy1(
                    courseInfo: state.courseInfo!,
                  ).show(context);
                }
              },
            ).show(context);
          } else {
            Navigator.of(context).pop();
            CourseStudy1(
              courseInfo: state.courseInfo!,
            ).show(context);
          }
        },
      ).show(context);
    }
  }
}
