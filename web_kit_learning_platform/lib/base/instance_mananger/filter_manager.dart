import 'package:webkit/services/apis/course/get_course_dictionary/get_course_directory_api.dart';
import 'package:webkit/services/apis/course/get_course_dictionary/get_course_directory_model.dart';

class FilterManager{
  static final FilterManager _singletonFilterManager = FilterManager._internal();
  static FilterManager get getInstance => _singletonFilterManager;
  factory FilterManager() {
    return _singletonFilterManager;
  }
  
  FilterManager._internal();

  GetAddCourseFilterModel? addCourseFilterModel;
  Future<GetAddCourseFilterModel?> getCourseFilter() async {
    if(addCourseFilterModel==null)
      {
        GetAddCourseFilterApi addCourseFilterApi = GetAddCourseFilterApi();
        addCourseFilterModel = await addCourseFilterApi.call();
      }
    return addCourseFilterModel;
  }
}