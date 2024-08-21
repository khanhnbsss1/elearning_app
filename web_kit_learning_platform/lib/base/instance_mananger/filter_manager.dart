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
  Future<Map<int, String>> getGradesInfo() async {
    Map<int, String> listOfGradeNames={};
    GetAddCourseFilterModel? addCourseFilterModel = await FilterManager().getCourseFilter();
    if(addCourseFilterModel!=null)
    {
      addCourseFilterModel.data?.forEach((data) {
        switch (data.filterType) {
          case 'GRADE':
            data.subFilter!.where((e) => e.name != null).forEach((e) {
              if (!listOfGradeNames.containsValue(e.name!)) {
                listOfGradeNames[e.id!] = e.name!;
              }
            });
            break;
          default:
            break;
        }
      });
    }
    return listOfGradeNames;
  }
}