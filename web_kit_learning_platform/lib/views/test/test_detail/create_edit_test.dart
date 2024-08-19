import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';
import '../../../base/widgets/widget_common/widget_with_title_common.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';

import 'components/search_question_drop_down.dart';
import 'test_detail_bloc/test_detail_bloc.dart';


class CreateEditTest extends StatefulWidget {
  TestInfo? testInfo;
   ActionType? testActionType;
   Function()?callBack;
   CreateEditTest({super.key, this.testInfo, this.testActionType, this.callBack}){
     testActionType??= ActionType.create;
   }

  void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * (ResponsiveInfo.isTablet() ? 0.4 : 0.9),
                height: MediaQuery.of(context).size.height * (ResponsiveInfo.isTablet() ? 0.8 : 0.9),
                key: UniqueKey(),
                child: this
            ),
          );
        });
  }

  @override
  State<CreateEditTest> createState() => _CreateEditLesson();
}

class _CreateEditLesson extends State<CreateEditTest>
    with TickerProviderStateMixin, UIMixin {

  var position = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  late TabController _tabController ;
  final valueListenable = ValueNotifier<TestType?>(null);

  String mode = 'FREE';
  int price = 0;
  late TestDetailState _state;
  late bool enableEdit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enableEdit = widget.testActionType!=ActionType.view;
    _tabController = TabController(length: 2, vsync: this);
    if(widget.testInfo!=null)
      {
        valueListenable.value = widget.testInfo?.getTestLevel();
      }

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Dimens.size20))
      ),
      clipBehavior: Clip.antiAlias,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConst.mainColor,
          iconTheme: IconThemeData(
            color: ColorConst.whiteColor, //change your color here
          ),
          title: Text( widget.testInfo?.id!=null?L10nX.getStr.test_update:L10nX.getStr.test_add, style: TextStyleConstant.textStyleBlack20w700.copyWith(color: ColorConst.whiteColor),),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: ColorConst.dividerColor, width: 1)),
            color: ColorConst.whiteColor
          ), 
            child: lectureDetail()),
      ),
    );
  }

  MultipartFile? selectedImage;
  final ImagePicker imagePicker = ImagePicker();

  Widget lectureDetail() {
    return BlocProvider(
      create: (context) {
        return TestDetailBloc(TestDetailState(testInfo: widget.testInfo,))
          ..add(TestDetailInitEvent());
      },
      child: BlocConsumer<TestDetailBloc, TestDetailState>(
        listener: (context, state) {
          switch (state.blocStatus) {
            case TestDetailStatus.initial:
              break;
            case TestDetailStatus.onCreateLesson:
              {
                Navigator.of(context).pop();
              }
              break;
            case TestDetailStatus.onUpdateLesson:
              {
                Navigator.of(context).pop();

              }
              break;
            default:
              break;
          }
          state.blocStatus = TestDetailStatus.unKnown;
        },
        builder: (BuildContext context, state) {
          _state= state;
          return LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorConst.whiteColor, width: 0.1)
                      ),
                      width: 450,
                      child: TabBar(
                        indicatorColor: ColorConst.mainColor,
                        dividerColor: Colors.transparent,
                        labelColor: ColorConst.mainColor,
                        overlayColor: WidgetStateProperty.all(Colors.red),
                        indicator: BoxDecoration(border: Border(bottom: BorderSide(color: ColorConst.mainColor))),
                        onTap: (index) {
                          _pageController.jumpToPage(index);
                          setState(() {
                            position = index;
                          });
                        },
                        tabs: [
                          buildTabItem(title: S.of(context).introduction_str, index:0),
                          buildTabItem(title: S.of(context).quiz_str, index: 1),
                        ],
                        controller: _tabController,
                      ),
                    ),
                    Divider(color: ColorConst.blackColor,thickness: 0.1,),
                    Expanded(
                        child: buildPageView(context: context, state: state)
                    ),
                    Divider(color: ColorConst.dividerColor.withOpacity(0.3),),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: widget.testActionType != ActionType.view,
                          child: ActionButton1(
                            text: widget.testActionType == ActionType.create?L10nX.getStr.create_str:L10nX.getStr.str_update,
                            width: Dimens.size150,
                            onTap: () {
                              state.testInfo??= TestInfo();
                              state.testInfo?.name = state.editingControllerTestName?.text;
                              state.testInfo?.durian = int.tryParse(state.editingControllerTestTime?.text??'0');
                              state.testInfo?.testType = valueListenable.value;
                              switch(widget.testActionType){
                          
                                case ActionType.view:
                                // TODO: Handle this case.
                                  break;
                                case ActionType.edit:
                                // TODO: Handle this case.
                                  {
                                    BlocProvider.of<TestDetailBloc>(context).add(TestDetailUpdateTestEvent(testInfo: state.testInfo!));
                                  }
                                  break;
                                case ActionType.create:
                                // TODO: Handle this case.
                                  {
                                    BlocProvider.of<TestDetailBloc>(context).add(TestDetailCreateTestEvent(testInfo: state.testInfo!));
                                  }
                                  break;
                                default:
                                  break;
                              }
                            },
                          ),
                        ),
                        Gap(Dimens.size20),
                        ActionButton1(
                          text: L10nX.getStr.close,
                          width: Dimens.size80,
                          enableBgColor: ColorConst.whiteColor,
                          textStype: TextStyleConstant.textStyleBlack14w400.copyWith(color: ColorConst.blackColor),
                          onTap: () {
                            Navigator.of(context).pop();

                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
  Tab buildTabItem( { required int index, required String title}){
    TextStyle textStyle = TextStyleConstant.textStyleBlack15w700.copyWith(
        color: (position == index?ColorConst.textColorSelectTabBar : ColorConst.subtext));
    return Tab(
      child: Container(
        height:(Dimens.size30),
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
  Widget buildPageView({required BuildContext context, required TestDetailState state}) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimens.size16,),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: [
          buildTestIntro(state: state, context: context),
          buildQuizList(context: context, state: state)
        ],
        onPageChanged: (value) {
          _tabController.animateTo(value);
          setState(() {
            position = value;
          });
        },
      ),
    );
  }

  Widget buildTestIntro({required BuildContext context, required TestDetailState state}){
    return Column(
      children: [
        Gap(Dimens.size16),
        buildTestName(context: context),
        Gap(Dimens.size16),
        Row(
          children: [
            Expanded(child: buildTestTime(context: context)),
            Gap(Dimens.size20),
            Expanded(child: buildTestType(context: context))
        ],)
      ],
    );
  }
  Widget buildTestName({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: L10nX.getStr.test_name,
      isRequirement: true,
      // titleStyle: ,
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: _state.editingControllerTestName,
        enabled: enableEdit,
        decoration: InputDecoration(
          labelText: L10nX.getStr.test_name,
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            Icons.title,
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
  Widget buildTestTime({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: "${L10nX.getStr.time_str} (${L10nX.getStr.time_in_minute_str.toLowerCase()})",
      isRequirement: true,
      // titleStyle: ,
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: _state.editingControllerTestTime,
        enabled: enableEdit,
        inputFormatters: 
        [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ],
        decoration: InputDecoration(
          labelText: L10nX.getStr.time_str,
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            Icons.timelapse,
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
  Widget buildTestType({required BuildContext context}) {
    List<TestType> items = enableEdit?TestType.values:[];
    return WidgetWithColumnTitleCommon(
      title: L10nX.getStr.type,
      isRequirement: true,
      child: Container(
        decoration: BoxDecoration(
          color: ColorConst.whiteColor
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<TestType>(
            isExpanded: true,
            hint: Text(
              L10nX.getStr.type,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: items.map((TestType item) => DropdownItem<TestType>(
              value: item,
             // height: 40,
              child: Text(
              L10nX().getStringByKey("${mapTestLevelToStrKey[item]??""}_test_str".toLowerCase()),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            )).toList(),
            valueListenable: valueListenable,
            onChanged: (TestType? value) {
              valueListenable.value = value;
            },
            buttonStyleData:  ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: ColorConst.whiteColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: ColorConst.greyColor)
              ),
              height: 56,
              //width: 140,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 120,
              //width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: ColorConst.whiteColor,
              ),
              offset: const Offset(0, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(16),
                thickness: WidgetStateProperty.all(0),
                thumbVisibility: WidgetStateProperty.all(false),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildQuizList({required BuildContext context, required TestDetailState state}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(Dimens.size16),
        Text(L10nX.getStr.choose_quest, style: TextStyleConstant.textStyleBlack13w500.copyWith(fontWeight:  FontWeight.w600),),
        Gap(Dimens.size4),
        Expanded(
          child: SearchQuizDropDown(
            actionType: widget.testActionType,
            exitsQuestion: state.listOfWord??[],
            allWords: const [],
            onAddWords: (tags) {
              state.listOfWordAdd!.add(tags);
              state.listOfWord!.add(tags);
              if((state.listOfWordRemove??[]).where((element) => element.id == tags.id).isNotEmpty)
                {
                  (state.listOfWordRemove??[]).removeWhere((element) => element.id == tags.id,);
                }
               BlocProvider.of<TestDetailBloc>(context).add(TestDetailUpdateQuizEvent(
                   listOfTest: state.listOfWord??[], 
                   listOfTestAdd: state.listOfWordAdd,
                 listOfTestRemove: state.listOfWordRemove
               ));
            },
            onRemoveWords: (tags) {
               (state.listOfWord??[]).removeWhere((element) => element.id == tags.id,);
               (state.listOfWordRemove??[]).add(tags);
               if((state.listOfWordAdd??[]).where((element) => element.id == tags.id).isNotEmpty)
               {
                 (state.listOfWordAdd??[]).removeWhere((element) => element.id == tags.id,);
               }
               BlocProvider.of<TestDetailBloc>(context).add(TestDetailUpdateQuizEvent(
                   listOfTest: state.listOfWord??[],
                   listOfTestAdd: state.listOfWordAdd,
                   listOfTestRemove: state.listOfWordRemove
               ));
            },
          ),
        ),
      ],
    );
  }
  
}
