// import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/drop_down/drop_down_search.dart';
import 'package:webkit/base/widgets/widget_common/widget_with_title_common.dart';
import 'package:webkit/controller/ui/add_course_controller.dart';
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/views/course/create_edit_course/bloc/add_course_bloc.dart';
import 'package:webkit/views/course/create_edit_course/components/tag_drop_down.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webkit/views/lessson/components/search_test_drop_down.dart';

class CourseIntroductionPage extends StatefulWidget {
  CourseIntroductionPage({super.key});
  void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => this,
    );
  }

  @override
  State<CourseIntroductionPage> createState() => _CourseIntroductionPageState();
}

class _CourseIntroductionPageState extends State<CourseIntroductionPage> with SingleTickerProviderStateMixin, UIMixin {
  late List<CourseInfo> coursesInfo;
  var position = 0;

  @override
  void initState() {
    super.initState();
  }

  List<LessonInfo> lectures = [];
  bool valueIsShowInLandingPage = false;
  bool valueIsStandard = false;
  bool valuePaymentMode = false;

  String? value2;

  MultipartFile? selectedImage;
  final ImagePicker imagePicker = ImagePicker();

  int? getIdFromName(Map<int, String> map, String name) {
    try {
      return map.entries.firstWhere((entry) => entry.value == name).key;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCourseBloc, AddCourseState>(
      listener: (context, state) {
        switch (state.blocStatus) {
          case AddCourseStatus.initial:
            break;
          default:
            break;
        }
        state.blocStatus= AddCourseStatus.unKnown;
      },
      builder: (BuildContext context, state) {
        return Material(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return buildAddCourse(constraints: constraints, state: state, context: context);
            },
          ),
        );
      },
    );
  }

  Widget buildAddCourse({required BoxConstraints constraints, required AddCourseState state, required BuildContext context}) {
    return GetBuilder<AddCourseController>(
      init: state.controller,
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            // color: Color.fromRGBO(255, 233, 233, 1.0),
            border: Border.all(
              color: ColorConst.colorHintTextSearch,
            ),
              borderRadius: BorderRadius.circular(Dimens.size16)

          ),
          padding: EdgeInsets.all(Dimens.size16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: controller.basicValidator.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyResponsive(
                    builder: (context, boxConstraints, myScreenMediaType) {
                      if (myScreenMediaType.isMobile) {
                        return buildCourseSummaryInfoMobile(context: context, state: state);
                      } else {
                        return buildCourseSummaryInfoWeb(context: context, state: state);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCourseSummaryInfoWeb({required AddCourseState state, required BuildContext context}) {
    double widthUnit = Dimens.size150;
    double maxWidthRow = widthUnit*2;

    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidthItem = maxWidthRow;
        double heightOfItem = 92;
        int numberRow = ((constraints.maxWidth / maxWidthItem)/2).toInt()*2;
        if(numberRow<1) {
          numberRow=1;
        }
        double widthItem = (constraints.maxWidth -(50* numberRow))/numberRow;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GridView.count(
              crossAxisSpacing: Dimens.size24,
              childAspectRatio: (widthItem)/(heightOfItem),
              mainAxisSpacing: 0,
              crossAxisCount: numberRow,
              shrinkWrap: true,
              children: [
                SizedBox(
                    width: widthUnit*2,
                    child: Row(
                      children: [
                        Expanded(child: buildCourseName(state: state, context: context)),
                      ],
                    )),
                SizedBox(
                  width: widthUnit,
                  child: Row(
                    children: [
                      Expanded(
                        child: buildAuthor(state: state, context: context),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: widthUnit,
                  child: Row(
                    children: [
                      Expanded(
                        child: buildGrade(state: state, context: context),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: widthUnit,
                  child: Row(
                    children: [
                      Expanded(
                        child: buildCategory(state: state, context: context),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: widthUnit,
                  child: Row(
                    children: [
                      Expanded(
                        child: buildDuration(state: state, context: context),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: widthUnit*2,
                  child: Row(
                    children: [
                      Expanded(
                        child: buildBackgroundImage(state: state, context: context),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: widthUnit*2,
                  child: Row(
                    children: [
                      Expanded(
                        child: buildVideoPreview(state: state, context: context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: buildIntroduction(state: state, context: context),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: buildWhatWillYouAchieve(state: state, context: context)),
                Gap(Dimens.size50),
                Expanded(child: buildWhoThisCourse(state: state, context: context)),
              ],
            ),
            buildPaymentWidget(state: state, context: context),
            SizedBox(
                width: maxWidthRow*2.6,
                child: WidgetWithColumnTitleCommon(
                  title: L10nX.getStr.primary_course,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buildStandard(state: state, context: context),
                      Gap(Dimens.size20),
                      Expanded(child: buildAccompanyCourse(state: state, context: context)),
                    ],
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: buildTags(state: state, context: context)),
                Expanded(child: buildCourseTest(state: state, context: context)),
              ],
            ),
          ],
        );
      }, 
    );
  }

  Widget buildCourseSummaryInfoMobile({required AddCourseState state, required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.size8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildCourseName(state: state, context: context),
          MySpacing.height(16),
          buildCategory(state: state, context: context),
          MySpacing.height(16),
          buildBackgroundImage(state: state, context: context),
          MySpacing.height(16),
          buildVideoPreview(state: state, context: context),
          MySpacing.height(16),
          buildAuthor(state: state, context: context),
          buildDuration(state: state, context: context),
          MySpacing.height(16),
          buildIntroduction(state: state, context: context),
          MySpacing.height(16),
          buildWhoThisCourse(state: state, context: context),
          MySpacing.height(16),
          buildWhatWillYouAchieve(state: state, context: context),
        /*  MySpacing.height(16),
          buildShowCourseInLandingPage(state: state, context: context),*/
          MySpacing.height(16),
          WidgetWithColumnTitleCommon(
              title: "${L10nX.getStr.standard_str} ",
              child: buildStandard(state: state, context: context)),
          MySpacing.height(8),
          buildAccompanyCourse(state: state, context: context),
          MySpacing.height(16),
          buildPaymentWidget(state: state, context: context),
          MySpacing.height(16),
          buildCourseTest(state: state, context: context),
          MySpacing.height(16),
          buildTags(state: state, context: context),
          MySpacing.height(20),
        ],
      ),
    );
  }

  
  Widget buildCourseName({required AddCourseState state, required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      title: L10nX.getStr.name,
      isRequirement: true,
      // titleStyle: ,
      child: TextFormField(
        validator: state.controller?.basicValidator.getValidation('name'),
        controller: state.controller?.basicValidator.getController('name'),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: L10nX.getStr.name,
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.user,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }

  Widget buildCategory({required AddCourseState state, required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      title: '${L10nX.getStr.category_str}',
      isRequirement: true,
      child: DropDownSearch(
          list: state.controller!.listOfCategoryName,
          hintText: '${L10nX.getStr.category_str}...',
          selectItem: state.courseInfo?.categoryName,
          controller: state.controller?.basicValidator.getController('category_name')),
    );
  }

  Widget buildBackgroundImage({required AddCourseState state, required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      title: '${L10nX.getStr.background_image_str}',
      // titleStyle: ,
      isRequirement: true,
      child: TextFormField(
        validator: state.controller?.basicValidator.getValidation('image'),
        controller: state.controller?.basicValidator.getController('image'),
        keyboardType: TextInputType.url,
        decoration: InputDecoration(
          labelText: L10nX.getStr.image_str,
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.mail,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon: IconButton(
            icon: Icon(Icons.image),
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg']);
              MultipartFile file = MultipartFile.fromBytes(result!.files.first.bytes!.toList(growable: true), filename: result.names[0]);
              setState(() {
                state.controller?.basicValidator.getController('image')?.text = result.files.first.name ?? "";
              });
              BlocProvider.of<AddCourseBloc>(context).add(AddCourseUploadImageEvent(uploadFileInfo: UploadFileInfo(
                  data: SubjectType.courses, 
                  fileName: result.files.first.name,
                  file: file
              )));
            },
          ),
        ),
      ),
    );
  }

  Widget buildVideoPreview({required AddCourseState state, required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      title: '${L10nX.getStr.video_preview_str}: ',
      isRequirement: true,
      // titleStyle: ,
      child: TextFormField(
        validator: state.controller?.basicValidator.getValidation('video_preview'),
        controller: state.controller?.basicValidator.getController('video_preview'),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Youtube url',
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.mail,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon: IconButton(
              onPressed: () async {
                return;
                FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['mp4']);
                MultipartFile file = MultipartFile.fromBytes(result!.files.first.bytes!.toList(growable: true), filename: result.names[0]);
                setState(() {
                  state.controller?.basicValidator.getController('video_preview')?.text = result.files.first.name ?? "";
                });
                BlocProvider.of<AddCourseBloc>(context).add(AddCourseUploadVideoPreViewEvent(
                    uploadFileInfo: UploadFileInfo(
                        data: SubjectType.courses,
                        fileName: result.files.first.name,
                        file: file)));
              },
              icon: Icon(
                Icons.video_call,
                color: ColorConst.colorIconRed,
              )),
        ),
      ),
    );
  }

  Widget buildAuthor({required AddCourseState state, required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      title: '${L10nX.getStr.author_str}',
      isRequirement: true,
      child: DropDownSearch(
          list: state.controller!.listOfProduceNames,
          hintText: '${L10nX.getStr.author_str}...',
          selectItem: state.courseInfo?.producerName,
          controller: state.controller?.basicValidator.getController('producer_name')),
    );
  }

  Widget buildDuration({required AddCourseState state, required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      title: L10nX.getStr.duration_str,
      isRequirement: true,
      child: TextFormField(
        validator: state.controller?.basicValidator.getValidation('durian'),
        controller: state.controller?.basicValidator.getController('durian'),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: '${L10nX.getStr.how_long_does_the_course_last_str} ?',
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.user,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }

  Widget buildWhoThisCourse({required AddCourseState state, required BuildContext context}) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        List<Widget> listWhoThisCourseWidget=[];
        for(TextEditingController infoObjectController in state.controller?.getListInfoObjectController()??[])
        {
          listWhoThisCourseWidget.add(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: infoObjectController,
                            onFieldSubmitted: (value) {
                
                            },
                            onEditingComplete: () {
                
                            },
                            onTapOutside: (event) {
                
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: L10nX.getStr.who_this_course_is_for,
                              labelStyle: MyTextStyle.bodySmall(xMuted: true),
                              border: outlineInputBorder,
                              prefixIcon: Icon(
                                LucideIcons.user,
                                size: 20,
                                color: ColorConst.colorIconRed,
                              ),
                              contentPadding: MySpacing.all(16),
                              isCollapsed: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                            ),
                          ),
                        ),
                        Gap(Dimens.size10),
                        IconButton(
                          onPressed: () {
                            state.controller?.removeInfoObjectController(textEditingController: infoObjectController);
                            BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateControllerEvent(addCourseController: state.controller!));
                          },
                          icon: Icon(Icons.remove_circle_outline, color: ColorConst.mainColor, size: Dimens.size20,),
                        )
                      ],
                    ),
                    Gap(Dimens.size10)
                  ],
                ),
              )
          );
        }
        return WidgetWithColumnTitleCommon(
          titleWidget: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(L10nX.getStr.who_this_course_is_for,style: TextStyleConstant.textStyleBlack13w500.copyWith(fontWeight:  FontWeight.w600)),
              Gap(Dimens.size10),
              IconButton(
                onPressed: () {
                  state.controller?.insertInfoObjectController(textEditingController: TextEditingController());
                  BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateControllerEvent(addCourseController: state.controller!));
                },
                icon: Icon(Icons.add_circle, color: ColorConst.mainColor, size: Dimens.size20,),
              ),
            ],),
          child:Column(
            mainAxisSize: MainAxisSize.min,
            children: listWhoThisCourseWidget,
          )
        );
      },
    );
  }

  Widget buildGrade({required AddCourseState state, required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
        title: L10nX.getStr.grade_str,
        isRequirement: true,
        child: DropDownSearch(
            list: state.controller!.listOfGradeNames,
            hintText: '${L10nX.getStr.grade_name_str}...',
            selectItem: (state.courseInfo?.gradeName),
            controller: state.controller?.basicValidator.getController('grade_name')));
  }

  Widget buildIntroduction({required AddCourseState state, required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      title: L10nX.getStr.introduction_str,
      child: TextFormField(
        validator: state.controller?.basicValidator.getValidation('introduction'),
        controller: state.controller?.basicValidator.getController('introduction'),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: '${L10nX.getStr.introduction_str} ?',
            alignLabelWithHint: true,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            labelStyle: MyTextStyle.bodySmall(xMuted: true),
            border: outlineInputBorder,
            contentPadding: MySpacing.all(16),
            isCollapsed: true,
            floatingLabelBehavior: FloatingLabelBehavior.never),
        minLines: 5,
        maxLines: 10,
      ),
    );
  }

  Widget buildWhatWillYouAchieve({required AddCourseState state, required BuildContext context}) {
    return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
      List<Widget> listWhoThisCourseWidget=[];
      for(TextEditingController infoObjectController in state.controller?.getListResultObjectController()??[])
      {
        listWhoThisCourseWidget.add(
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                          key: UniqueKey(),
                          controller: infoObjectController,
                          onFieldSubmitted: (value) {
              
                          },
                          onEditingComplete: () {
              
                          },
                          onTapOutside: (event) {
              
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: L10nX.getStr.what_will_you_achieve_after_the_course_str,
                            labelStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            prefixIcon: Icon(
                              LucideIcons.user,
                              size: 20,
                              color: ColorConst.colorIconRed,
                            ),
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                      Gap(Dimens.size10),
                      IconButton(
                        onPressed: () {
                          state.controller?.removeResultObjectController(textEditingController: infoObjectController);
                          BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateControllerEvent(addCourseController: state.controller!));
                        },
                        icon: Icon(Icons.remove_circle_outline, color: ColorConst.mainColor, size: Dimens.size20,),
                      )
                    ],
                  ),
                  Gap(Dimens.size10),
                ],
              ),
            )
        );
      }
      return WidgetWithColumnTitleCommon(
        titleWidget: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(L10nX.getStr.what_will_you_achieve_after_the_course_str,
                overflow:TextOverflow.clip,
                style: TextStyleConstant.textStyleBlack13w500.copyWith(fontWeight:  FontWeight.w600)),
            Gap(Dimens.size10),
            IconButton(
              onPressed: () {
                state.controller?.insertResultObjectController(textEditingController: TextEditingController());
                BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateControllerEvent(addCourseController: state.controller!));
              },
              icon: Icon(Icons.add_circle, color: ColorConst.mainColor, size: Dimens.size20,),
            )
          ],),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: listWhoThisCourseWidget,
        ),
      );
    },
    );
  }
  
  Widget buildStandard({required AddCourseState state, required BuildContext context}) {
    return WidgetWithRowTitleCommon(
        titleWidget: InkWell(
          onTap: () {
            setState(() {
              if(state.courseInfo?.isStandard==1)
                {

                  state.courseInfo?.isStandard =  0;
                }
              else
                {
                  state.courseInfo?.isStandard =  1;
                }
              state.controller?.basicValidator.getController('is_standard')?.text = valueIsStandard == true ? '1' : '0';
              BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateControllerEvent(courseInfo:  state.courseInfo, addCourseController: state.controller!));
            });
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                color: Colors.white,
                border: Border.all(
                  color: Colors.black87,
                ),
              ),
              width: 20,
              height: 20,
              child: (state.courseInfo?.isStandard==1)
                  ? Icon(
                      Icons.check,
                      size: 15,
                      color: ColorConst.colorIconGrays,
                    )
                  : null),
        ),
        crossAxisAlignment: CrossAxisAlignment.end,
        child: Text(
          ' ${L10nX.getStr.primary_course}',
          style: TextStyleConstant.textStyleBlack14w400,
        ));
  }

  Widget buildAccompanyCourse({required AddCourseState state, required BuildContext context}) {
    return DropDownSearch(
        list: state.controller!.listOfAccompanyCourses,
        hintText: "${L10nX.getStr.accompany_course_str}...",
        selectItem: (state.courseInfo?.accompanyCourse ?? '0').toInt(),
        controller: state.controller?.basicValidator.getController('accompany_course'));
  }

  Widget buildTags({required AddCourseState state, required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      title: "${L10nX.getStr.tags}",
      isRequirement: true,
      child: TagDropDown(
        allTags: state.controller!.listOfTags,
        onAddTags: (tags) {
          (state.courseInfo?.tags??[]).add(tags);
          BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateControllerEvent(addCourseController: state.controller!));
        },
        exitsTags: state.courseInfo?.tags,
        onRemoveTags: (tags) {
          (state.courseInfo?.tags??[]).removeWhere((element) => element.name == tags.name,);
          BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateCourseInfoEvent(courseInfo: state.courseInfo!));
        },
      ),
    );
  }

  Widget buildPaymentWidget({required AddCourseState state, required BuildContext context}) {
    if (ResponsiveInfo.isTablet()) {
      return Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 20,
        children: [
          Text('${L10nX.getStr.payment_str}: ', style: TextStyleConstant.textStyleBlack13w500.copyWith(fontWeight: FontWeight.w600),),
          SizedBox(
            width: Dimens.size120,
            child: WidgetWithRowTitleCommon(
                titleWidget: InkWell(
                  onTap: () {
                      setState(() {
                        (state.courseInfo?.mode=='FREE') ?
                        state.courseInfo?.mode = 'PREMIUM'
                            : (state.courseInfo?.mode=='PREMIUM')
                            ? state.courseInfo?.mode =  'FREE'
                            : state.courseInfo?.mode =  'FREE';
                        state.controller?.basicValidator.getController('payment_mode')?.text = state.courseInfo?.mode??"FREE";
                        BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateControllerEvent(courseInfo:  state.courseInfo, addCourseController: state.controller!));
                      });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black87,
                        ),
                      ),
                      width: 20,
                      height: 20,
                      child: ((state.courseInfo?.mode??"FREE")=="FREE")
                          ? Icon(
                              Icons.check,
                              size: 15,
                              color: ColorConst.colorIconGrays,
                            )
                          : null),
                ),
                crossAxisAlignment: CrossAxisAlignment.end,
                child: Text(
                  L10nX.getStr.free_str,
                  style: TextStyleConstant.textStyleBlack14w400,
                )),
          ),
          SizedBox(
            width: Dimens.size120,
            child: WidgetWithRowTitleCommon(
                titleWidget: InkWell(
                  onTap: () {
                    setState(() {
                      (state.courseInfo?.mode=='FREE') ?
                       state.courseInfo?.mode = 'PREMIUM'
                        : (state.courseInfo?.mode=='PREMIUM')
                      ? state.courseInfo?.mode =  'FREE'
                      : state.courseInfo?.mode =  'PREMIUM';
                      state.controller?.basicValidator.getController('payment_mode')?.text = state.courseInfo?.mode??"PREMIUM";
                      BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateControllerEvent(courseInfo:  state.courseInfo, addCourseController: state.controller!));
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black87,
                        ),
                      ),
                      width: 20,
                      height: 20,
                      child:  (state.courseInfo?.mode??"PREMIUM")=="PREMIUM"
                          ? Icon(
                        Icons.check,
                        size: 15,
                        color: ColorConst.colorIconGrays,
                      )
                          : null),
                ),
                crossAxisAlignment: CrossAxisAlignment.end,
                child: Text(
                  L10nX.getStr.premium_str,
                  style: TextStyleConstant.textStyleBlack14w400,
                )),
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: Dimens.size250,
            ),
            child: WidgetWithRowTitleCommon(
              title: "${L10nX.getStr.price} ",
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: Dimens.size200,
                ),
                child: TextFormField(
                  validator: state.controller?.basicValidator.getValidation('payment_value'),
                  controller: state.controller?.basicValidator.getController('payment_value'),
                  keyboardType: TextInputType.number,
                  enabled: (state.courseInfo?.mode??"FREE")=="PREMIUM",
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    suffix: Text("VND"),
                    //labelText: 'Result after the course',
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      labelText: L10nX.getStr.price,
                      alignLabelWithHint: true,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      border: outlineInputBorder,
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                  minLines: 1,
                  maxLines: 1,
                ),
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: Dimens.size300,
            ),
            child: WidgetWithRowTitleCommon(
              title: "${L10nX.getStr.discount_str}",
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: Dimens.size200,
                ),
                child: Opacity(
                  opacity: ((state.courseInfo?.mode)=="PREMIUM") ? 1 : 0.2,
                  child: IgnorePointer(
                    ignoring: (state.courseInfo?.mode)!="PREMIUM",
                    child: DropDownSearch(
                      list: {},//state.controller!.listOfAccompanyCourses,
                      hintText: "${L10nX.getStr.discount_str}...",
                      selectItem: "80.0",
                      controller: state.controller?.basicValidator.getController('payment_discount')),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return WidgetWithColumnTitleCommon(
          title: '${L10nX.getStr.payment_str}: ',
          isRequirement: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WidgetWithRowTitleCommon(
                      titleWidget: InkWell(
                        onTap: () {
                          setState(() {
                            valuePaymentMode = !valuePaymentMode;
                            state.controller?.basicValidator.getController('payment_mode')?.text = valuePaymentMode == true ? '0' : '1';
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black87,
                              ),
                            ),
                            width: 20,
                            height: 20,
                            child: !valuePaymentMode
                                ? Icon(
                              Icons.check,
                              size: 15,
                              color: ColorConst.colorIconGrays,
                            )
                                : null),
                      ),
                      crossAxisAlignment: CrossAxisAlignment.end,
                      child: Text(
                        L10nX.getStr.free_str,
                        style: TextStyleConstant.textStyleBlack14w400,
                      )),
                  Gap(Dimens.size20),
                  WidgetWithRowTitleCommon(
                      titleWidget: InkWell(
                        onTap: () {
                          setState(() {
                            valuePaymentMode = !valuePaymentMode;
                            state.controller?.basicValidator.getController('payment_mode')?.text = valuePaymentMode == true ? '1' : '0';
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black87,
                              ),
                            ),
                            width: 20,
                            height: 20,
                            child: valuePaymentMode
                                ? Icon(
                              Icons.check,
                              size: 15,
                              color: ColorConst.colorIconGrays,
                            )
                                : null),
                      ),
                      crossAxisAlignment: CrossAxisAlignment.end,
                      child: Text(
                        L10nX.getStr.premium_str,
                        style: TextStyleConstant.textStyleBlack14w400,
                      )),
                ],
              ),
              Gap(Dimens.size20),
              Opacity(
                opacity: valuePaymentMode==false ? 0.2 : 1,
                child: IgnorePointer(
                  ignoring: valuePaymentMode==false,
                  child: TextFormField(
                    validator: state.controller?.basicValidator.getValidation('payment_value'),
                    controller: state.controller?.basicValidator.getController('payment_value'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      //labelText: 'Result after the course',
                        labelStyle: MyTextStyle.bodySmall(xMuted: true),
                        labelText: L10nX.getStr.price,
                        alignLabelWithHint: true,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        border: outlineInputBorder,
                        contentPadding: MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                    minLines: 1,
                    maxLines: 1,
                  ),
                ),
              ),
              Gap(Dimens.size20),
              Opacity(
                opacity: valuePaymentMode==false ? 0.2 : 1,
                child: IgnorePointer(
                  ignoring: valuePaymentMode==false,
                  child: DropDownSearch(
                      list: state.controller!.listOfAccompanyCourses,
                      hintText: "${L10nX.getStr.discount_str}...",
                      selectItem: "80.0",
                      controller: state.controller?.basicValidator.getController('payment_discount')),
                ),
              ),
            ],
          ));
    }
  }
  Widget buildCourseTest({required BuildContext context, required AddCourseState state}) {
    return WidgetWithColumnTitleCommon(
      title: L10nX.getStr.output_test_str,
      isRequirement: true,
      child: SearchTestDropDown(
       // key: UniqueKey(),
        testInfo: state.testInfo,
        onSelectTest: (testInfo) {
          BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateTestInfoEvent(testInfo: testInfo));
        },
      ),
    );
  }
}
