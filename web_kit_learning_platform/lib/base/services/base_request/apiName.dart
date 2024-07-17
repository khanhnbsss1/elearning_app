class ApiName {
  static ApiName ?_instance = ApiName();

  static ApiName getInstance() {
    _instance ??= ApiName();
    return _instance!;
  }

  final int connectTimeout = 30000;
  final int readTimeout = 20000;

  //user auth
  final String login = "/login";
  final String loginByPhone = "/login-phone";
  final String registerUserByUserName = "/register";
  final String registerUserByPhone = "/register-phone";
  final String registerTeacherByUserName = "/register-teacher";
  final String registerTeacherByPhone = "/register-phone-teacher";
  final String refreshToken = "/refresh-token";
  final String deleteAccount = "/delete-account";

  //user role
  final String createRole = "/create-role";
  final String editUserRole = "/edit-user-role";
  final String editRole = "/edit-role";
  final String deleteRole = "/delete-role";
  
  final String LOGOUT = "/logout";
  
  ///course 
  final String createCourse = "/create-course";
  final String updateCourse = "/update-course";
  final String getCourseList = "/filter-courses";
  final String getMyCourses = "/get-my-courses";
  final String getCourseDetail = "/get-course-detail";
  final String deleteCourse = "/delete-course";
  final String getFilterCourse = "/filter-directory";
  
  /// landing page

  final String getCourseListLandingPage = "/get-course-landingpage";
  final String getTeacherListLandingPage = "/get-landingpage-teacher";
  final String getReviewListLandingPage = "/get-landingpage-review";
  
  /// thong tin nguoi dung
  final String createUser = "/create-course";
  final String editUser = "/edit-user";
  final String getUserDetail = "/get-user";


}

