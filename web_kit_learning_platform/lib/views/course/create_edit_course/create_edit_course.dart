// import 'dart:io';
import 'package:file/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/course/course_list/models/course_models.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/views/course/create_edit_course/components/course_preview_2.dart';
import 'bloc/add_course_bloc.dart';
import 'components/course_introduction.dart';
import 'components/course_preview.dart';
import 'components/create_lession_list.dart';

enum CoursePageType{
  create,
  edit
}

class CreateEditCourse extends StatefulWidget {
  CreateEditCourse({super.key, this.courseInfo, required this.coursePageType, this.onNext});
  CourseInfo? courseInfo;
  CoursePageType coursePageType;
  void Function()? onNext;
  void show(BuildContext context) {
    showGeneralDialog(
      context: context,
        pageBuilder: (context, animation, secondaryAnimation) => this,);
  }

  @override
  State<CreateEditCourse> createState() => _CreateEditCourseState();
}

class _CreateEditCourseState extends State<CreateEditCourse> with SingleTickerProviderStateMixin, UIMixin {

  final MultiSelectController multiSelectController = MultiSelectController();
  late AnimationController animationController;
  late List<CourseInfo> coursesInfo;
  late TabController _tabController ;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  var position = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  List<LessonInfo> lectures = [];
  bool value = false;

  String? value2;

  File? selectedImage;
  final ImagePicker imagePicker = ImagePicker();
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AddCourseBloc(AddCourseState(courseInfo: widget.courseInfo,))..add(AddCourseInitEvent());
      },
      child: BlocConsumer<AddCourseBloc, AddCourseState>(
        listener: (context, state) {
          switch (state.blocStatus) {
            case AddCourseStatus.initial:
              break;
            default:
              break;
          }
        }, builder: (BuildContext context, state) {
          return Material(
            child: LayoutBuilder(
                builder: (context, constraints) {
                  return buildCourseCommonPage(state: state, buildContext: context);
                },
            ),
          );
      },
      )
    );
  }

  Widget buildCourseCommonPage({required BuildContext buildContext, required AddCourseState state}){
    bool isExitCourse = (state.courseInfo?.id!=null) && (state.courseInfo?.id!=0);

    return Container(
      decoration: BoxDecoration(
        color: ColorConst.whiteColor
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorConst.dividerColor)
              )
            ),
            padding: EdgeInsets.symmetric(vertical: Dimens.size16, horizontal: Dimens.size24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackButtonCustom(buildContext: buildContext),
                    Gap(Dimens.size16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(isExitCourse?L10nX.getStr.course_edit:L10nX.getStr.course_create, style: TextStyleConstant.textStyleBlack30w700,),
                        Visibility(
                          visible: ResponsiveInfo.isTablet(),
                          child: Text("Course / Course list / ${!isExitCourse?"Create course":"Edit course"}", style: TextStyleConstant.textStyleBlack16w400.copyWith(color: ColorConst.colorHintTextSearch),),
                        )
                      ],
                    )
                  ],
                ),
                MyResponsive(
                  builder: (buildContext , boxConstraints , myScreenMediaType ) {
                    if(myScreenMediaType.isMobile)
                      {
                        return Row(
                          children: [
                            InkWell(
                              onTap: () {
                                
                              },
                              child: Tooltip(
                                message: L10nX.getStr.save_update_str,
                                child: Icon(Icons.save_outlined, size: Dimens.size30,color: ColorConst.mainColor,),
                              ),
                            ),
                            Gap(Dimens.size16),
                            InkWell(
                              onTap: () {

                              },
                              child: Tooltip(
                                message: L10nX.getStr.save_update_str,
                                child: Icon(Icons.remove_red_eye, size: Dimens.size30,color: ColorConst.colorIconGrays,),
                              ),
                            ),
                          ],
                        );

                      }
                    else
                      {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ActionButton1(
                              text: L10nX.getStr.save_update_str,
                              onTap: () async {
                                 await onSubmitCourse(state: state);
                              },
                            ),
                            Gap(Dimens.size16),
                            ActionButton1(
                              preIcon: Icon(Icons.remove_red_eye, color: ColorConst.colorIconGrays,),
                              text: L10nX.getStr.preview_str,
                              textStype: TextStyleConstant.textStyleBlack16w600,
                              enableBgColor: ColorConst.whiteColor,
                              onTap: () {
                                CoursePreview(courseInfo: state.courseInfo!,).show(context);
                              },
                            )
                          ],
                        );
                      }
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Dimens.size16),
            child: tabBar(state: state),
          ),
          Expanded(child: buildPageView(context: context, state: state)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: position == 0 && state.courseInfo?.id==0,
                child: ActionButton1(
                  text: L10nX.getStr.course_create,
                  onTap: () {
                    BlocProvider.of<AddCourseBloc>(buildContext).add(AddCourseSubmitAddEvent(addCourseController: state.controller!));
                  },
                ),
              ),
              Visibility(
                visible: position >0 && state.courseInfo?.id != 0,
                child: ActionButton1(
                  text: L10nX.getStr.string_back,
                  onTap: () {
                    setState(() {
                      position = position-1;
                    });
                    _pageController.jumpToPage(position);
                  },
                ),
              ),
              Gap(Dimens.size20),

              Visibility(
                visible: position < 3 && state.courseInfo?.id != 0,
                child: ActionButton1(
                  text: L10nX.getStr.next,
                  onTap: () {
                    setState(() {
                      position = position+1;
                    });
                    _pageController.jumpToPage(position);

                  },
                ),
              ),
            ],
          ),
          Gap(Dimens.size10),
        ],
      ),
    );
  }
  
  Widget tabBar({ required AddCourseState state}) {
    bool isExitCourse = (state.courseInfo?.id!=null) && (state.courseInfo?.id!=0);
    TextStyle textStyle = TextStyleConstant.textStyleBlack15w700.copyWith(
        color: isExitCourse?(position == 0?ColorConst.textColorSelectTabBar : ColorConst.subtext):ColorConst.greyColor.withOpacity(0.3));
    return Material(
      elevation: 4,
      child: Container(
          decoration: BoxDecoration(
              color: ColorConst.whiteColor,
              borderRadius: BorderRadius.circular((Dimens.size0))
          ),
          constraints: BoxConstraints(
            minWidth: Dimens.size200*2,
            maxWidth: Dimens.size200*3
          ),
          alignment: Alignment.center,
          child: TabBar(
            indicatorColor: ColorConst.mainColor,
            dividerColor: Colors.transparent,
            labelColor: ColorConst.mainColor,
            overlayColor: WidgetStateProperty.all(Colors.red),
            indicator: BoxDecoration(border: Border(bottom: BorderSide(color: ColorConst.mainColor))),
            onTap: (index) {
               if(!isExitCourse) {
                 _pageController.jumpToPage(0);
                 _tabController.animateTo(0);
                 return;
               }
              _pageController.jumpToPage(index);
              setState(() {
                position = index;
              });
            },
            tabs: [
              buildTabItem(state: state, title: S.of(context).introduction_str, index:0),
              buildTabItem(state: state, title: S.of(context).content_str, index: 1),
              buildTabItem(state: state, title: S.of(context).pricing_plan_str, index: 2),
              buildTabItem(state: state, title: S.of(context).create_quiz_str, index: 3),

            ],
            controller: _tabController,
          ),
        ),
    );
  }
  Tab buildTabItem( { required int index,required AddCourseState state, required String title}){
    bool isExitCourse = (state.courseInfo?.id!=null) && (state.courseInfo?.id!=0);
    TextStyle textStyle = TextStyleConstant.textStyleBlack15w700.copyWith(
        color: isExitCourse?(position == index?ColorConst.textColorSelectTabBar : ColorConst.subtext):ColorConst.greyColor.withOpacity(0.3));
    if(index==0){
      textStyle = TextStyleConstant.textStyleBlack15w700.copyWith(color: position == 0  ?ColorConst.textColorSelectTabBar : ColorConst.subtext);
    }
    return Tab(
      child: Container(
        height:(Dimens.size40),
        alignment: Alignment.center,
        child: Center(
          child: Text(
            title,
            style: textStyle,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
  Widget buildPageView({required BuildContext context, required AddCourseState state}) {
    bool isExitCourse = (state.courseInfo?.id!=null) && (state.courseInfo?.id!=0);
    return Padding(
      padding: EdgeInsets.only(bottom: Dimens.size16, left: Dimens.size16, right: Dimens.size16),
      child: PageView(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: [
          CourseIntroductionPage(),
          CourseLinkLessonListPage(),
          SizedBox(),
          SizedBox()
          ],
        
        onPageChanged: (value) {
          if(!isExitCourse) {
            _pageController.jumpToPage(0);
            _tabController.animateTo(0);
            return;
          }
          _tabController.animateTo(value);
          setState(() {
            position = value;
          });
        },
      ),
    );
  }
  
  Future<void> onSubmitCourse({required AddCourseState state}) async {
    await state.controller?.getCourseInfoFromUI(courseInfo: state.courseInfo!);
  }
}

