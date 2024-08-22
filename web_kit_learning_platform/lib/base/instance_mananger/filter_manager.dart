import 'package:webkit/services/apis/category/get_category_list.dart';
import 'package:webkit/services/apis/category/models/category_info.dart';
import 'package:webkit/services/apis/course/course_fillter/get_course_fillter_api.dart';
import 'package:webkit/services/apis/course/course_fillter/models/course_filtter_info.dart';
import 'package:webkit/services/apis/course/get_course_dictionary/get_course_directory_api.dart';
import 'package:webkit/services/apis/course/get_course_dictionary/get_course_directory_model.dart';
import 'package:webkit/services/apis/grade/get_grade_list.dart';
import 'package:webkit/services/apis/grade/models/grade_info.dart';

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
  CourseFilterListInfo courseFilterListInfo = CourseFilterListInfo(data: []);
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
      GetCategoryListApi api = GetCategoryListApi();
      categoryListResponseModel = await api.call();
    }
    return categoryListResponseModel;
  }
}