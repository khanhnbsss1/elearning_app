// import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/widget_common/widget_with_title_common.dart';
import 'package:webkit/controller/ui/add_course_controller.dart';
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/my_screen_media.dart';
import 'package:webkit/helpers/widgets/my_screen_media_type.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/course/course_list/models/course_models.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/views/course/create_edit_course/bloc/add_course_bloc.dart';
import 'package:webkit/views/course/create_edit_course/components/tag_drop_down.dart';
import 'package:file_picker/file_picker.dart';

class CourseIntroductionPage extends StatefulWidget {
  
  CourseIntroductionPage({super.key});
  void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => this,);
  }

  @override
  State<CourseIntroductionPage> createState() => _CourseIntroductionPageState();
}

class _CourseIntroductionPageState extends State<CourseIntroductionPage> with SingleTickerProviderStateMixin, UIMixin {

  final MultiSelectController multiSelectController = MultiSelectController();
  late List<CourseInfo> coursesInfo;
  var position = 0;

  @override
  void initState() {
    super.initState();
  }

  List<Lectures> lectures = [];
  bool value = false;

  String? value2;

  MultipartFile? selectedImage;
  final ImagePicker imagePicker = ImagePicker();
  

  int? getIdFromName(Map<int, String> map, String name) {
    try {
      return map.entries
          .firstWhere((entry) => entry.value == name)
          .key;
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
      }, builder: (BuildContext context, state) {
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
  Widget buildAddCourse(
      {required BoxConstraints constraints,required AddCourseState state, required BuildContext context}) {
    state.addCourseFilterModel?.data?.forEach((data) {
      switch (data.filterType) {
        case 'CATEGORY':
          data.subFilter!.where((e) => e.name != null).forEach((e) {
            if (!state.controller!.listOfCategoryName.containsValue(e.name!)) {
              state.controller!.listOfCategoryName[e.id!] = e.name!;
            }
          });
          break;
        case 'AUTHOR':
          data.subFilter!.where((e) => e.name != null).forEach((e) {
            if (!state.controller!.listOfProduceNames.containsValue(e.name!)) {
              state.controller!.listOfProduceNames[e.id!] = e.name!;
            }
          });
          break;
        case 'GRADE':
          data.subFilter!.where((e) => e.name != null).forEach((e) {
            if (!state.controller!.listOfGradeNames.containsValue(e.name!)) {
              state.controller!.listOfGradeNames[e.id!] = e.name!;
            }
          });
          break;
        case 'ACCOMPANY':
          data.subFilter!.where((e) => e.name != null).forEach((e) {
            if (!state.controller!.listOfAccompanyCourses.containsValue(e.name!)) {
              state.controller!.listOfAccompanyCourses[e.id!] = e.name!;
            }
          });
          break;
        case 'TAG':
          data.subFilter!.where((e) => e.name != null).forEach((e) {
            if (!state.controller!.listOfTags.containsValue(e.name!)) {
              state.controller!.listOfTags[e.id!] = e.name!;
            }
          });
          break;
        default:
          break;
      }
    });
    
    return GetBuilder<AddCourseController>(
      init: state.controller,
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            // color: Color.fromRGBO(255, 233, 233, 1.0),
            border: Border.all(
              color: ColorConst.colorHintTextSearch,
            ),
          ),
          padding: EdgeInsets.all(Dimens.size16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(Dimens.size16),
              child: Form(
                key: controller.basicValidator.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyResponsive(builder: (context, boxConstraints, myScreenMediaType) {
                      if(myScreenMediaType.isMobile)
                        {
                          return buildCourseSummaryInfoMobile(context: context, state: state);
                        }
                      else
                        {
                          return buildCourseSummaryInfoWeb(context: context, state: state);
                        }
                    }, ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Widget buildCourseSummaryInfoWeb({required AddCourseState state, required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.size16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: buildCourseName(state: state, context: context),
              ),
              MySpacing.width(20),
              Expanded(
                child: buildCategory(state: state, context: context),
              ),
            ],
          ),
          // MySpacing.height(20),
          MySpacing.height(20),
          Row(
            children: [
              Expanded(
                child: buildBackgroundImage(state: state, context: context),
              ),
              MySpacing.width(20),
              Expanded(
                child: buildVideoPreview(state: state, context: context),
              ),
            ],
          ),
          MySpacing.height(20),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: buildAuthor(state: state, context: context),
              ),
              MySpacing.width(20),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDuration(state: state, context: context),
                  ],
                ),
              ),
              MySpacing.width(20),
              Expanded(
                flex: 2,
                child: buildWhoThisCourse(state: state, context: context),
              ),
              MySpacing.width(20),
              Expanded(
                flex: 2,
                child: buildGrade(state: state, context: context),
              ),
            ],
          ),
          MySpacing.height(20),
          buildIntroduction(state: state, context: context),
          MySpacing.height(20),
          buildWhatWillYouAchieve(state: state, context: context),
          MySpacing.height(20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildShowCourseInLandingPage(state: state, context: context),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildStandard(state: state, context: context),
                  Gap(Dimens.size20),
                  SizedBox(
                      width: Dimens.size200 * 2,
                      child: buildAccompanyCourse(state: state, context: context),)
                ],
              ),
            ],
          ),
          MySpacing.height(20),
          buildTags(state: state, context: context),
          MySpacing.height(20),

        ],
      ),
    );
  }
  Widget buildCourseSummaryInfoMobile({required AddCourseState state, required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.size16),
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
          buildWhatWillYouAchieve(state: state, context: context),
          MySpacing.height(16),
          buildShowCourseInLandingPage(state: state, context: context),
          MySpacing.height(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildStandard(state: state, context: context),
              Gap(Dimens.size20),
              Expanded(
                child: buildAccompanyCourse(state: state, context: context),
              )
            ],
          ),
          buildTags(state: state, context: context),
          MySpacing.height(20),

        ],
      ),
    );
  }
  Widget buildCourseName({required AddCourseState state, required BuildContext context}){
    return  WidgetWithColumnTitleCommon(
      title: '${L10nX.getStr.name}: ',
      isRequirement: true,
      // titleStyle: ,
      child: TextFormField(
        validator: state.controller?.basicValidator
            .getValidation('name'),
        controller: state.controller?.basicValidator
            .getController('name'),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Name',
          labelStyle:
          MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.user,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior:
          FloatingLabelBehavior.never,
        ),
      ),
    );
  }
  Widget buildCategory({required AddCourseState state, required BuildContext context}){
    return  WidgetWithColumnTitleCommon(
      title: '${L10nX.getStr.category_str}: ',
      isRequirement: true,
      // titleStyle: ,
      child: DropdownButtonFormField<int>(
        dropdownColor: theme.cardTheme.color,
        decoration: InputDecoration(
          labelText: value2 ?? 'Category',
          labelStyle:
          MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.phone,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior:
          FloatingLabelBehavior.never,
        ),
        items: state.controller!.listOfCategoryName.entries.map((entry) {
          return DropdownMenuItem<int>(
            value: entry.key,
            child: Text(entry.value),
          );
        }).toList(),

        onChanged: (value) {
          state.controller?.basicValidator.getController('category_id')?.text = value!.toString();
          BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateControllerEvent(addCourseController: state.controller!));
        },

      ),
    );
  }
  Widget buildBackgroundImage({required AddCourseState state, required BuildContext context}){
    return  WidgetWithColumnTitleCommon(
      title: '${L10nX.getStr.background_image_str}: ',
      // titleStyle: ,
      isRequirement: true,
      child: TextFormField(
        validator: state.controller?.basicValidator
            .getValidation('image'),
        controller: state.controller?.basicValidator
            .getController('image'),
        keyboardType: TextInputType.url,
        decoration: InputDecoration(
          labelText: 'Image',
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.mail,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior:
          FloatingLabelBehavior.never,
          suffixIcon: IconButton(
            icon: Icon(Icons.image),
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['png', 'jpg']
              );
              MultipartFile file = MultipartFile.fromBytes(result!.files.first.bytes!.toList(growable: true),filename: result.names[0]);
              setState(() {
                state.controller?.basicValidator.getController('image')?.text = result.files.first.name??"";
              });
              BlocProvider.of<AddCourseBloc>(context).add(AddCourseUploadImageEvent(uploadFileInfo: UploadFileInfo(data: SubjectType.courses, file: file)));
            },
          ),
        ),
      ),
    );
  }
  Widget buildVideoPreview({required AddCourseState state, required BuildContext context}){
    return  WidgetWithColumnTitleCommon(
      title: '${L10nX.getStr.video_preview_str}: ',
      isRequirement: true,
      // titleStyle: ,
      child: TextFormField(
        validator: state.controller?.basicValidator
            .getValidation('video_review'),
        controller: state.controller?.basicValidator
            .getController('video_review'),
        keyboardType: TextInputType.url,
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
          floatingLabelBehavior:
          FloatingLabelBehavior.never,
          suffixIcon: InkWell(
              onTap: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['mp4']
                );
                MultipartFile file = MultipartFile.fromBytes(result!.files.first.bytes!.toList(growable: true),filename: result.names[0]);
                setState(() {
                  state.controller?.basicValidator.getController('video_review')?.text = result.files.first.name??"";
                });
                BlocProvider.of<AddCourseBloc>(context).add(AddCourseUploadVideoPreViewEvent(uploadFileInfo: UploadFileInfo(data: SubjectType.courses, file: file)));

              },
              child: Icon(Icons.video_call, color: ColorConst.colorIconRed,)),
        ),
      ),
    );
  }
  Widget buildAuthor({required AddCourseState state, required BuildContext context}){
    return  WidgetWithColumnTitleCommon(
      title: '${L10nX.getStr.author_str}: ',
      isRequirement: true,
      child: customDropDownSearch(
          list: state.controller!.listOfProduceNames,
          hintText: '${L10nX.getStr.author_str}...',
          selectItem: state.courseInfo?.producerName,
          controller: state.controller?.basicValidator.getController('producer_name')),
    );
  }
  Widget buildDuration({required AddCourseState state, required BuildContext context}){
    return  WidgetWithColumnTitleCommon(
      title: '${L10nX.getStr.duration_str}: ',
      isRequirement: true,
      child: TextFormField(
        validator: state.controller?.basicValidator.getValidation('durian'),
        controller: state.controller?.basicValidator.getController('durian'),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: '${L10nX.getStr.how_long_does_the_course_last_str} ?',
          labelStyle:
          MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.user,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior:
          FloatingLabelBehavior.never,
        ),
      ),
    );
  }
  Widget buildWhoThisCourse({required AddCourseState state, required BuildContext context}){
    return  WidgetWithColumnTitleCommon(
      title: '${L10nX.getStr.who_this_course_is_for} ?',
      child: TextFormField(
        validator: state.controller?.basicValidator
            .getValidation('info_obj'),
        controller: state.controller?.basicValidator
            .getController('info_obj'),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: '${L10nX.getStr.who_this_course_is_for} ?',
          labelStyle:
          MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.user,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior:
          FloatingLabelBehavior.never,
        ),
      ),
    );
  }
  Widget buildGrade({required AddCourseState state, required BuildContext context}){
    return  WidgetWithColumnTitleCommon(
        title: '${L10nX.getStr.grade_str} ?',
        child: customDropDownSearch(list: state.controller!.listOfGradeNames,
            hintText: '${L10nX.getStr.grade_name_str} ?',
            selectItem: (state.courseInfo?.gradeName??'0').toInt(),
            controller: state.controller?.basicValidator.getController('grade_name'))
    );
  }
  Widget buildIntroduction({required AddCourseState state, required BuildContext context}){
    return  WidgetWithColumnTitleCommon(
      title: '${L10nX.getStr.introduction_str} ?',
      child: TextFormField(
        validator: state.controller?.basicValidator
            .getValidation('introduction'),
        controller: state.controller?.basicValidator
            .getController('introduction'),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: '${L10nX.getStr.introduction_str} ?',
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
            floatingLabelBehavior:
            FloatingLabelBehavior.never),
        minLines: 5,
        maxLines: 10,
      ),
    );
  }
  Widget buildWhatWillYouAchieve({required AddCourseState state, required BuildContext context}){
    return  WidgetWithColumnTitleCommon(
      title: L10nX.getStr.what_will_you_achieve_after_the_course_str,
      child: TextFormField(
        validator: state.controller?.basicValidator.getValidation('info_result'),
        controller: state.controller?.basicValidator.getController('info_result'),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        decoration: InputDecoration(
          //labelText: 'Result after the course',
            labelStyle: MyTextStyle.bodySmall(xMuted: true),
            labelText: 'Result after the course',
            alignLabelWithHint: true,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            border: outlineInputBorder,
            // prefixIcon: const Icon(
            //   LucideIcons.lock,
            //   size: 20,
            // ),
            contentPadding: MySpacing.all(16),
            isCollapsed: true,
            floatingLabelBehavior:
            FloatingLabelBehavior.never),
        minLines: 5,
        maxLines: 10,
      ),
    );
  }
  Widget buildShowCourseInLandingPage({required AddCourseState state, required BuildContext context}){
    return  WidgetWithRowTitleCommon(
      titleWidget: InkWell(
        onTap: () {
          setState(() {
            value = !value;
            value == true ? state.controller?.basicValidator
                .getController('is_show_course_in_landing_page')
                ?.text = '1'
                : state.controller?.basicValidator
                .getController('is_show_course_in_landing_page')
                ?.text = '0';
          });
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              border: Border.all(
                color: Colors.black87,
              ),
            ),
            width: 20,
            height: 20,
            child: value ? Icon(
              Icons.check,
              size: 15,
              color: ColorConst.colorIconGrays,
            ) : null
        ),),
      child: Text(L10nX.getStr.show_course_in_landing_page_str, style: TextStyleConstant.textStyleBlack14w400,),
    );
  }
  Widget buildStandard({required AddCourseState state, required BuildContext context}){
    return  WidgetWithRowTitleCommon(
      titleWidget: InkWell(
        onTap: () {
          setState(() {
            value = !value;
             state.controller?.basicValidator.getController('is_standard')?.text = value == true ?'1' :'0'; 
          });
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              color: Colors.red,
              border: Border.all(
                color: Colors.black87,
              ),
            ),
            width: 20,
            height: 20,
            child: value ? Icon(
              Icons.check,
              size: 15,
              color: ColorConst.colorIconGrays,
            ) : null
        ),),
      crossAxisAlignment: CrossAxisAlignment.end,
      child: Text(L10nX.getStr.standard,style: TextStyleConstant.textStyleBlack14w400,)
    );
  }
  Widget buildAccompanyCourse({required AddCourseState state, required BuildContext context}){
    return  WidgetWithColumnTitleCommon(
      title: '${L10nX.getStr.accompany_course_str}: ',
      isRequirement: true,
      child: customDropDownSearch(
          list: state.controller!.listOfAccompanyCourses,
          hintText: 'Accompany',
          selectItem: (state.courseInfo?.accompanyCourse??'0').toInt(),
          controller: state.controller?.basicValidator.getController('accompany_course')),
    );
  }
  Widget buildTags({required AddCourseState state, required BuildContext context}){
    return  WidgetWithColumnTitleCommon(
      title: "${L10nX.getStr.tags}: ",
      isRequirement: true,
      child: TagDropDown(tags: state.controller!.listOfTags.values.toList(),
        onAddTags: (tags) {
          state.controller?.basicValidator.getController('tags')?.text = tags.join(',');
          BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateControllerEvent(addCourseController: state.controller!));

        }, onRemoveTags: (tags) {
          final currentTags = state.controller?.basicValidator.getController('tags')?.text.split(',').map((tag) => tag.trim()).toList();
          final removedTags = currentTags?.where((tag) => !tags.contains(tag)).toList();
          
          final newTags = tags.where((tag) => !currentTags!.contains(tag)).toList();
          state.controller?.basicValidator.getController('tags')?.text = [...newTags, ...?currentTags?.where((tag) => !removedTags!.contains(tag))].join(',');
          BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateControllerEvent(addCourseController: state.controller!));
        },),
    );
  }
  
  
  Widget customDropDownSearch(
      {
        required Map<int, String> list,
        required String hintText,
        required TextEditingController? controller,
        dynamic selectItem
      }){
    String selectString = selectItem.toString();
    if(selectItem.runtimeType == int){
      selectString = list[selectItem as int]??"";
    }
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        constraints: BoxConstraints(
          maxHeight: (65 + list.length * 50 < 210) ? 65 + list.length * 50 : 210,
        ),
        showSearchBox: true,
        searchDelay: Duration(seconds: 0),
        showSelectedItems: true,
      ),
      items: list.values.toList(),
      selectedItem: selectString,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: hintText,
          hintStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.book,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior:
          FloatingLabelBehavior.never,
        ),
      ),
      onChanged: (value) {
        controller?.text = value??"";
      },
    );
  }
}

