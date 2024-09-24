import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/base/widgets/drop_down/drop_down_search.dart';
import 'package:webkit/base/widgets/drop_down/drop_down_search_custom.dart';
import 'package:webkit/services/apis/category/get_category_list.dart';
import 'package:webkit/services/apis/category/models/category_info.dart';
import 'package:webkit/services/apis/course/course_fillter/get_course_fillter_api.dart';
import 'package:webkit/services/apis/course/course_fillter/models/course_filtter_info.dart';
import 'package:webkit/services/apis/course/course_progress/get_course_proccess_list.dart';
import 'package:webkit/services/apis/course/course_progress/models/course_proccess_info.dart';
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
import 'package:webkit/services/apis/tags/models/tag_info.dart';
import 'package:webkit/services/apis/test/get_test_list_api.dart';

import '../../services/apis/test/models/test_info.dart';
import '../../services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import '../../services/apis/vocabulary/vocabulary_list/vocabulary_list_api.dart';
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
  VocabularyResponseModel vocabularyResponseModel = VocabularyResponseModel(content: []);
  CourseProgressResponseModel courseProgressResponseModel = CourseProgressResponseModel(content: []);
  List<bool>calApi = [false,false,false,false,false, false, false, false, false, false, false, false ];

  FilterInfo filterInfo = FilterInfo(
    listOfAccompanyCourses: {},
    listOfCategoryName: {},
    listOfDiscounts: {},
    listOfGradeNames: {},
    listOfProduceNames: {},
    listOfTags: []
  );
  Future<void> init()async {
    await getFilterCourse();
  }

  Future<CourseFilterListInfo> getFilterCourse() async {
    if((courseFilterListInfo.data??[]).isNotEmpty || calApi[0]!=false) {
      return courseFilterListInfo;
    }
    calApi[0]=true;
    GetCourseFilterApi getCourseFilterApi = GetCourseFilterApi();
    courseFilterListInfo = await getCourseFilterApi.call();
    calApi[0]=false;
    return courseFilterListInfo;
  }

  Future<QuestionListResponseModel> getQuestionListAll(String keyword,{bool? isReload}) async {
  isReload??=false;
    if(((questionListResponseModel.content??[]).isNotEmpty&& isReload==false) || calApi[1]!=false) {
      return questionListResponseModel;
    }
  calApi[1]=true;
    GetQuizListApi getQuizFilterApi = GetQuizListApi(searchCommonRequest: SearchCommonRequest(pageNumber: -1));
    questionListResponseModel = await getQuizFilterApi.call();
  calApi[1]=false;
    return questionListResponseModel;
  }
  
  Future<QuestionListResponseModel> getFilterQuestion({bool? isReload}) async {
    isReload??=false;
    
    if(((questionListResponseModel.content??[]).isNotEmpty && isReload==false) || calApi[2]!=false) {
      return questionListResponseModel;
    }
    calApi[2]=true;
    GetQuizFilterApi getQuizFilterApi = GetQuizFilterApi();
    questionListResponseModel = await getQuizFilterApi.call();
    calApi[2]=false;
    return questionListResponseModel;
  }


  Future<TestListResponseModel> getTestListAll(String keyword, {bool? isReload}) async {
    isReload??=false;
    if(((testListResponseModel.content??[]).isNotEmpty&& isReload==false) || calApi[3]!=false) {
      return testListResponseModel;
    }
    calApi[3]=true;
    GetTestListApi getTestFilterApi = GetTestListApi(searchCommonRequest: SearchCommonRequest(pageNumber: -1));
    testListResponseModel =  await getTestFilterApi.call();
    calApi[3]=false;
    return testListResponseModel;
  }
  
  Future<TestListResponseModel> getFilterTest() async {
    if((testListResponseModel.content??[]).isNotEmpty || calApi[5]!=false) {
      return testListResponseModel;
    }
    calApi[5]=true;
    GetTestFilterApi getTestFilterApi = GetTestFilterApi();
    testListResponseModel =  await getTestFilterApi.call();
    calApi[5]=false;
    return testListResponseModel;
  }
  
  Future<FilterInfo> getCourseFilter() async {
    if((addCourseFilterModel==null|| (addCourseFilterModel?.data??[]).isEmpty) && calApi[6]==false)
      {
        calApi[6]=true;
        GetAddCourseFilterApi addCourseFilterApi = GetAddCourseFilterApi();
        addCourseFilterModel = await addCourseFilterApi.call();
        calApi[6]=false;
        addCourseFilterModel?.data?.forEach((data) {
          switch (data.filterType) {
            case 'CATEGORY':
              data.subFilter!.where((e) => e.name != null).forEach((e) {
                if (!filterInfo.listOfCategoryName.containsValue(e.name!)) {
                  filterInfo.listOfCategoryName[e.id!] = e.name!;
                }
              });
              break;
            case 'AUTHOR':
              data.subFilter!.where((e) => e.name != null).forEach((e) {
                if (!filterInfo.listOfProduceNames.containsValue(e.name!)) {
                  filterInfo.listOfProduceNames[e.id!] = e.name!;
                }
              });
              break;
            case 'GRADE':
              data.subFilter!.where((e) => e.name != null).forEach((e) {
                if (!filterInfo.listOfGradeNames.containsValue(e.name!)) {
                  filterInfo.listOfGradeNames[e.id!] = e.name!;
                }
              });
              break;
            case 'ACCOMPANY':
              data.subFilter!.where((e) => e.name != null).forEach((e) {
                if (!filterInfo.listOfAccompanyCourses.containsValue(e.name!)) {
                  filterInfo.listOfAccompanyCourses[e.id!] = e.name!;
                }
              });
              break;
            case 'TAG':
              data.subFilter!.where((e) => e.name != null).forEach((e) {
                if (filterInfo.listOfTags.where((element) => element.id == e.id,).isEmpty) {
                  filterInfo.listOfTags.add(TagsInfo(id: e.id, name: e.name));
                }
              });
            case 'DISCOUNT':
              data.subFilter!.where((e) => e.name != null).forEach((e) {
                if (!filterInfo.listOfDiscounts.containsValue(e.name!)) {
                  filterInfo.listOfDiscounts[e.id!] = e.name!;
                }
              });
              break;
            default:
              break;
          }
        });
      }

    return filterInfo;
  }
  Future<GradeListResponseModel?> getGradesInfo() async {
    if((gradeListResponseModel==null || (gradeListResponseModel?.content??[]).isEmpty) && calApi[7]!=false)
    {
      calApi[7]=true;
      GetGradeListApi api = GetGradeListApi();
      gradeListResponseModel = await api.call();
      calApi[7]=false;
    }
    return gradeListResponseModel;
  }

  Future<CategoryListResponseModel?> getCategoryFilter() async {
    if((categoryListResponseModel==null|| (categoryListResponseModel?.content??[]).isEmpty)&& calApi[8]==false)
    {
      calApi[8]=true;
      GetCategoryListApi api =GetCategoryListApi();
      categoryListResponseModel = await api.call();
      calApi[8]=false;
    }
    return categoryListResponseModel;
  }
  Future<LessonListResponseModel?> getLessonListAllInfo(String keyword, {bool ?isReload}) async {
    isReload??=false;
    if(((lessonListResponseModel?.content??[]).isNotEmpty && isReload==false)|| calApi[9]!=false) {
      return lessonListResponseModel;
    }
    calApi[9]=true;
    GetLessonListApi getLessonListFilterApi = GetLessonListApi(searchCommonRequest: SearchCommonRequest(pageNumber: -1));
    lessonListResponseModel =  await getLessonListFilterApi.call();
    calApi[9]=false;
    return lessonListResponseModel;
  }

  Future<VocabularyResponseModel?> getVocabularyListAllInfo(String keyword, {bool ?isReload}) async {
    isReload??=false;
    if(((vocabularyResponseModel.content??[]).isNotEmpty && isReload==false)||calApi[10]||false) {
      return vocabularyResponseModel;
    }
    calApi[10]=true;
    GetListVocabularyApi getLessonListFilterApi = GetListVocabularyApi(
        searchCommonRequest: SearchCommonRequest(pageNumber: -1, vocabularyType: "", pageSize: 100));
    vocabularyResponseModel =  await getLessonListFilterApi.call();
    calApi[10]=false;
    return vocabularyResponseModel;
  }
  Future<CourseProgressResponseModel?> getCourseProccessListInfo({bool? isReload}) async {
    isReload??=false;
    if(((courseProgressResponseModel.content??[]).isNotEmpty && isReload==false)||calApi[11]!=false) {
      return courseProgressResponseModel;
    }
    calApi[11]=true;
    GetCourseProccessListApi getLessonListFilterApi = GetCourseProccessListApi();
    courseProgressResponseModel =  await getLessonListFilterApi.call();
    calApi[11]=false;
    return courseProgressResponseModel;
  }

  
  
  Widget buildGrade({
    required BuildContext context,
    Function(GradeInfo?)? onChanged,
    bool? enable,
    int? inputGradeId,
    String? gradeName,
    double? width,
    String? title,
    bool? enableInit,
    
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
        else if(data.isNotEmpty && (enableInit??true))
        {
          selectGrade = data.first;
          if(onChanged!=null)
          {
            onChanged(selectGrade);
          }
        }
        return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
          return SizedBox(
            width: width??Dimens.size180,
            child: WidgetWithColumnTitleCommon(
              title: title??"${L10nX.getStr.grade_str}: ",
              isRequirement: true,
              child: SizedBox(
                height: Dimens.size40,
                width: width??Dimens.size200,
                child: IgnorePointer(
                    ignoring: !(enable??true),
                    child:
                    DropDownSearchCustom<GradeInfo>(
                      items: (filter, loadProps) => data,
                      itemsData: data,
                      compareFn: (item1, item2) {
                        return true;
                      },
                      dropDownItemBuilder: (p0, p1, p2, p3) {
                        return ListTile(
                          title: Text(p1.name??"",
                              maxLines: 1,
                              style: TextStyleConstant.textStyleBlack14w400),
                          titleTextStyle: TextStyleConstant.textStyleBlack14w400,
                        );
                      },
                      hintText: L10nX.getStr.grade_str,
                      dropdownBuilder: (p0, p1) {
                        return Text(
                          p1?.name??"",
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          style: TextStyleConstant.textStyleBlack13w400,
                        );
                      },
                      prefixIcon: Icons.grade,
                      onChanged: (p0) {
                          if(onChanged!=null)
                          {
                            onChanged(p0);
                          }
                      },
                      itemAsString: (item) {
                        return item.name??"";
                      },
                      selectedItem: selectGrade,
                    )
                ),
              ),
            ),
          );
        },
        );

      },);
  }
  Widget buildCategory(
      {
        required BuildContext context,
      Function(CategoryInfo?)? onChanged,
      bool? enable,
      bool? enableInit,
      int? inputCategoryId,
      double? width,
      String? title,
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
        else if(enableInit??true)
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
            title:title?? "${L10nX.getStr.category_str}: ",
            isRequirement: true,
            child: SizedBox(
              height: Dimens.size40,
              width:width?? Dimens.size300,
              child: IgnorePointer(
                ignoring: !(enable??true),
                child: DropDownSearchCustom(
                  items: (filter, loadProps) => data,
                  itemsData: data,
                  compareFn: (item1, item2) {
                    return true;
                  },
                  dropDownItemBuilder: (p0, p1, p2, p3) {
                    return ListTile(
                      title: Text(p1.name??"", 
                          maxLines: 1,
                          style: TextStyleConstant.textStyleBlack14w400),
                      titleTextStyle: TextStyleConstant.textStyleBlack14w400,
                    );
                  },
                  hintText: L10nX.getStr.category_str,
                  dropdownBuilder: (p0, p1) {
                   return Text(
                      p1?.name??"",
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      style: TextStyleConstant.textStyleBlack13w400,
                    );
                  },
                prefixIcon: Icons.my_library_books_rounded,
                  onChanged: (p0) {
                    if(onChanged!=null)
                    {
                      onChanged(p0);
                    }
                  },
                  itemAsString: (item) {
                    return item.name??"";
                  },
                  selectedItem: selectCategory,
                )
              ),
            ),
          ),
        );

      },);
  }
  Widget buildMode(
      {
        required BuildContext context,
        Function(String?)? onChanged,
        bool? enable,
        bool? enableInit,
        String? mode,
        double? width,
        String? title,
      }){
    List<String> modes = ['Free','Premium' ];
    String selectMode = "";
    if(modes.where((element) => element == mode,).isNotEmpty)
    {
      selectMode= modes.firstWhere((element) => element == mode,);
    }
    else if(enableInit??true)
    {
      selectMode = modes.first;
      if(onChanged!=null)
      {
        onChanged(mode);
      }
    }
    return SizedBox(
      width: width??Dimens.size200,
      child: WidgetWithColumnTitleCommon(
        title:title?? "${L10nX.getStr.payment_str}: ",
        isRequirement: true,
        child: SizedBox(
          height: Dimens.size40,
          child: IgnorePointer(
              ignoring: !(enable??true),
              child: DropDownSearchCustom<String>(
                items: (filter, loadProps) => modes,
                itemsData: modes,
                compareFn: (item1, item2) {
                  return true;
                },
                dropDownItemBuilder: (p0, p1, p2, p3) {
                  return ListTile(
                    minTileHeight: Dimens.size20,
                    title: Text((p1??"").isNotEmpty?L10nX().getStringByKey("${p1.toLowerCase()}_str"):"",
                        maxLines: 1,
                        style: TextStyleConstant.textStyleBlack14w400),
                    titleTextStyle: TextStyleConstant.textStyleBlack14w400,
                  );
                },
                hintText: L10nX.getStr.payment_str,
                dropdownBuilder: (p0, p1) {
                  return Text(
                    (p1??"").isNotEmpty?L10nX().getStringByKey("${p1?.toLowerCase()}_str"):"",
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    style: TextStyleConstant.textStyleBlack13w400,
                  );
                },
                prefixIcon: Icons.attach_money,
                onChanged: (p0) {
                  if(onChanged!=null)
                  {
                    onChanged(p0);
                  }
                },
                itemAsString: (item) {
                  return item??"";
                },
                selectedItem: selectMode,
              )
          ),
        ),
      ),
    );
  }
  Widget buildAuthor({
    required BuildContext context,
    Function(MapEntry productInfo)? onChanged,
    bool? enable,
    String? producerName,
    double? width,
    String? title,
  }) {
    return SizedBox(
      width: width??Dimens.size200,
      child: WidgetWithColumnTitleCommon(
        title: title??L10nX.getStr.author_str,
        isRequirement: true,
        child: FutureBuilder(
          future: getCourseFilter(), 
          builder: (context, snapshot) {
          return SizedBox(
            height: Dimens.size40,
            width:width?? Dimens.size200,
            child: DropDownSearch(
              list: filterInfo.listOfProduceNames,
              hintText: '${L10nX.getStr.author_str}...',
              selectItem: producerName,
              onChange: (p0) {
                if(onChanged!=null) {
                  onChanged(p0);
                }
              },
            ),
          );
        },)
      ),
    );
  }
}



class FilterInfo {
  Map<int,String> listOfCategoryName = {};
  Map<int,String> listOfProduceNames = {};
  Map<int,String> listOfGradeNames = {};
  Map<int,String> listOfAccompanyCourses = {};
  List<TagsInfo> listOfTags = [];
  Map<int,String> listOfDiscounts = {};

  FilterInfo({
    required this.listOfAccompanyCourses, 
    required this.listOfCategoryName,
    required this.listOfDiscounts, 
    required this.listOfGradeNames,
    required this.listOfProduceNames,
    required this.listOfTags
  }){
    listOfAccompanyCourses??={};
    listOfCategoryName??={};
    listOfDiscounts??={};
    listOfGradeNames??={};
    listOfTags??=[];
    listOfProduceNames??={};
  }
}