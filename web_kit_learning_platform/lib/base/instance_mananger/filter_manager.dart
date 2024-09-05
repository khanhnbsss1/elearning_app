import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/category/get_category_list.dart';
import 'package:webkit/services/apis/category/models/category_info.dart';
import 'package:webkit/services/apis/course/course_fillter/get_course_fillter_api.dart';
import 'package:webkit/services/apis/course/course_fillter/models/course_filtter_info.dart';
import 'package:webkit/services/apis/course/get_course_dictionary/get_course_directory_api.dart';
import 'package:webkit/services/apis/course/get_course_dictionary/get_course_directory_model.dart';
import 'package:webkit/services/apis/filter/get_quiz_filter_api.dart';
import 'package:webkit/services/apis/filter/get_test_list_filter_api.dart';
import 'package:webkit/services/apis/grade/get_grade_list.dart';
import 'package:webkit/services/apis/grade/models/grade_info.dart';
import 'package:webkit/services/apis/lessson/lesson_list/lesson_list_api.dart';
import 'package:webkit/services/apis/lessson/lesson_list_filter/lesson_list_filter_api.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/question/get_quiz_list_api.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';
import 'package:webkit/services/apis/test/get_test_list_api.dart';

import '../../services/apis/test/models/test_info.dart';
import '../widgets/widget_common/widget_with_title_common.dart';

class FilterManager{
  static final FilterManager _singletonFilterManager = FilterManager._internal();
  static FilterManager get getInstance => _singletonFilterManager;
  factory FilterManager() {
    return _singletonFilterManager;
  }
  
  FilterManager._internal();

  GetAddCourseFilterModel? addCourseFilterModel;
  CategoryListResponseModel? categoryListResponseModel;
  GradeListResponseModel? gradeListResponseModel;
  LessonListResponseModel? lessonListResponseModel = LessonListResponseModel(content: []);
  CourseFilterListInfo courseFilterListInfo = CourseFilterListInfo(data: []);
  QuestionListResponseModel questionListResponseModel = QuestionListResponseModel(content: []);
  TestListResponseModel testListResponseModel = TestListResponseModel(content: []);
  Future<void> init()async {
    await getFilterCourse();
   await getCourseFilter();
   await getCategoryFilter();
   await getGradesInfo();

  }

  Future<CourseFilterListInfo> getFilterCourse() async {
    if((courseFilterListInfo.data??[]).isNotEmpty) {
      return courseFilterListInfo;
    }
    GetCourseFilterApi getCourseFilterApi = GetCourseFilterApi();
    return await getCourseFilterApi.call();
  }

  Future<QuestionListResponseModel> getQuestionListAll(String keyword) async {
/*    if((questionListResponseModel.content??[]).isNotEmpty) {
      return questionListResponseModel;
    }*/
    GetQuizListApi getQuizFilterApi = GetQuizListApi(searchCommonRequest: SearchCommonRequest(keyword: keyword));
    questionListResponseModel = await getQuizFilterApi.call();
    return questionListResponseModel;
  }
  
  Future<QuestionListResponseModel> getFilterQuestion() async {
    if((questionListResponseModel.content??[]).isNotEmpty) {
      return questionListResponseModel;
    }
    GetQuizFilterApi getQuizFilterApi = GetQuizFilterApi();
    questionListResponseModel = await getQuizFilterApi.call();
    return questionListResponseModel;
  }


  Future<TestListResponseModel> getTestListAll(String keyword) async {
/*    if((testListResponseModel.content??[]).isNotEmpty) {
      return testListResponseModel;
    }*/
    GetTestListApi getTestFilterApi = GetTestListApi(searchCommonRequest: SearchCommonRequest(keyword: keyword));
    testListResponseModel =  await getTestFilterApi.call();
    return testListResponseModel;
  }
  
  Future<TestListResponseModel> getFilterTest() async {
    if((testListResponseModel.content??[]).isNotEmpty) {
      return testListResponseModel;
    }
    GetTestFilterApi getTestFilterApi = GetTestFilterApi();
    testListResponseModel =  await getTestFilterApi.call();
    return testListResponseModel;
  }
  
  Future<GetAddCourseFilterModel?> getCourseFilter() async {
    if(addCourseFilterModel==null|| (addCourseFilterModel?.data??[]).isEmpty)
      {
        GetAddCourseFilterApi addCourseFilterApi = GetAddCourseFilterApi();
        addCourseFilterModel = await addCourseFilterApi.call();
      }
    return addCourseFilterModel;
  }
  Future<GradeListResponseModel?> getGradesInfo() async {
    if(gradeListResponseModel==null || (gradeListResponseModel?.content??[]).isEmpty)
    {
      GetGradeListApi api = GetGradeListApi();
      gradeListResponseModel = await api.call();
    }
    return gradeListResponseModel;
  }

  Future<CategoryListResponseModel?> getCategoryFilter() async {
    if(categoryListResponseModel==null|| (categoryListResponseModel?.content??[]).isEmpty)
    {
      GetCategoryListApi api =GetCategoryListApi();
      categoryListResponseModel = await api.call();
    }
    return categoryListResponseModel;
  }
  Future<LessonListResponseModel?> getLessonListAllInfo(String keyword) async {
/*    if((lessonListResponseModel?.content??[]).isNotEmpty) {
      return lessonListResponseModel;
    }*/
    GetLessonListApi getLessonListFilterApi = GetLessonListApi(searchCommonRequest: SearchCommonRequest(keyword: keyword));
    lessonListResponseModel =  await getLessonListFilterApi.call();
    return lessonListResponseModel;
  }
  Future<LessonListResponseModel?> getLessonFilterInfo() async {
    if((lessonListResponseModel?.content??[]).isNotEmpty) {
      return lessonListResponseModel;
    }
    GetLessonListFilterApi getLessonListFilterApi = GetLessonListFilterApi();
    lessonListResponseModel =  await getLessonListFilterApi.call();
    return lessonListResponseModel;
  }
  
  Widget buildGrade({
    required BuildContext context,
    Function(GradeInfo?)? onChanged,
    bool? enable,
    int? inputGradeId,
    String? gradeName,
    double? width,
    
  }){
    enable??=true;
    return FutureBuilder(
      future: FilterManager().getGradesInfo(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return SizedBox();
        }
        List<GradeInfo> data = snapshot.data?.content??[];
        GradeInfo? selectGrade ;
        if(data.where((element) => element.id == inputGradeId,).isNotEmpty)
        {
          selectGrade = data.firstWhere((element) => element.id == inputGradeId,);
        }
        else if((gradeName??"").isNotEmpty){
          if(data.where((element) => element.name == gradeName,).isNotEmpty)
          {
            selectGrade = data.firstWhere((element) => element.name == gradeName,);
          }
        }
        else
        {
          selectGrade = data.first;
          if(onChanged!=null)
          {
            onChanged(selectGrade);
          }
        }
        return SizedBox(
          width: width??Dimens.size200,
          child: WidgetWithColumnTitleCommon(
            title: "${L10nX.getStr.grade_str}: ",
            isRequirement: true,
            child: SizedBox(
              height: Dimens.size40,
              width: width??Dimens.size200,
              child: IgnorePointer(
                ignoring: !(enable??true),
                child: DropdownButtonFormField2<GradeInfo>(
                  isExpanded: true,
                  valueListenable: ValueNotifier<GradeInfo?>(selectGrade),
                  decoration: InputDecoration(
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding:  EdgeInsets.symmetric(vertical: Dimens.size16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimens.size16),
                    ),

                    // Add more decoration..
                  ),
                  hint:  Text(
                    L10nX.getStr.grade_str,
                    style: TextStyleConstant.textStyleBlack13w400,
                  ),
                  items: data.map((item) => DropdownItem<GradeInfo>(
                    value: item,
                    child: Text(
                      item.name??"",
                      style: TextStyleConstant.textStyleBlack13w400,
                    ),
                  )).toList(),
                  validator: (value) {
                    if (value == null) {
                      return L10nX.getStr.grade_str;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if(onChanged!=null) {
                      onChanged(value);
                    }
                  },
                  onSaved: (value) {
                  },
                  buttonStyleData:  ButtonStyleData(
                    height: Dimens.size40,
                    padding: EdgeInsets.only(right: Dimens.size8),
                  ),
                  iconStyleData:  IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: Dimens.size24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight:Dimens.size150,
                    //width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.size16),
                      color: ColorConst.whiteColor,
                    ),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.size16),
                  ),
                ),
              ),
            ),
          ),
        );

      },);
  }
  Widget buildCategory(
      {
        required BuildContext context,
      Function(CategoryInfo?)? onChanged,
      bool? enable,
      int? inputCategoryId,
        double? width,
      }){
    return FutureBuilder(
      future: FilterManager().getCategoryFilter(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return SizedBox();
        }
        List<CategoryInfo> data = snapshot.data?.content??[];
        CategoryInfo? selectCategory;
        if(data.where((element) => element.id == inputCategoryId,).isNotEmpty)
        {
          selectCategory= data.firstWhere((element) => element.id == inputCategoryId,);
        }
        else
        {
          selectCategory = data.first;
          if(onChanged!=null)
          {
            onChanged(selectCategory);
          }
        }
        
        return SizedBox(
          width: width??Dimens.size200,
          child: WidgetWithColumnTitleCommon(
            title: "${L10nX.getStr.category_str}: ",
            isRequirement: true,
            child: SizedBox(
              height: Dimens.size40,
              width:width?? Dimens.size200,
              child: IgnorePointer(
                ignoring: !(enable??true),
                child: DropdownButtonFormField2<CategoryInfo>(
                  key: UniqueKey(),
                  isExpanded: true,
                  valueListenable: ValueNotifier<CategoryInfo?>(selectCategory),
                  decoration: InputDecoration(
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding:  EdgeInsets.symmetric(vertical: Dimens.size16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimens.size16),
                    ),

                    // Add more decoration..
                  ),
                  hint:  Text(
                    L10nX.getStr.choose_category_str,
                    style: TextStyleConstant.textStyleBlack13w400,
                  ),
                  items: data.map((item) => DropdownItem<CategoryInfo>(
                    value: item,
                    child: Text(
                      item.name??"",
                      style: TextStyleConstant.textStyleBlack13w400,
                    ),
                  )).toList(),
                  validator: (value) {
                    if (value == null) {
                      return L10nX.getStr.choose_category_str;
                    }
                    return null;
                  },
                  onChanged: (value) {
                   if(onChanged!=null)
                     {
                       onChanged(value);
                     }
                  },
                  onSaved: (value) {
                  },
                  buttonStyleData:  ButtonStyleData(
                    height: Dimens.size40,
                    padding: EdgeInsets.only(right: Dimens.size8),
                  ),
                  iconStyleData:  IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: Dimens.size24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight:Dimens.size150,
                    //width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.size16),
                      color: ColorConst.whiteColor,
                    ),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.size16),
                  ),
                ),
              ),
            ),
          ),
        );

      },);
  }
}