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
  final String addCourseDirectory = "/add-course-directory";

  ///Lesson
  final String getLessonListFilter = "/get-list-filter";
  final String createLesson = "/create-lecture";
  final String deleteLesson = "/delete-lecture";
  final String updateLesson = "/update-lecture";
  final String getDetailLesson = "/get-detail";
  final String linkLesson = "/update-lecture-course";
  final String unlinkLesson = "/unlink-lecture-course";
  final String getLessonList = "/get-list";
  
  /// landing page

  final String getCourseListLandingPage = "/get-course-landingpage";
  final String getTeacherListLandingPage = "/get-landingpage-teacher";
  final String getReviewListLandingPage = "/get-landingpage-review";
  
  /// thong tin nguoi dung
  final String createUser = "/create-course";
  final String editUser = "/edit-user";
  final String getUserDetail = "/get-user";

 /// them tu dien
  final String addVocabulary = "/create-vocabulary";
  final String getListVocabulary = "/get-list";
  final String updateVocabulary = "/update-vocabulary";
  final String linkVocabulary = "/link-vocabulary";
  final String unlinkVocabulary = "/unlink-multiple-vocabulary";

  /// file
  final String addUploadFile = "/upload-file";
  final String addUploadMultiFile = "/upload-multiple-file";

  ///tag
  final String getTagsList = "/get-tags";
  final String createTag = "/create-tag";
  final String updateTag = "/update-tag";
  final String deleteTag = "/delete-tag";

  ///test
  final String getTestList = "/get-tests";
  final String createTest = "/create-test";
  final String updateTest = "/update-test";
  final String deleteTest = "/delete-test";
  final String detailTest = "/get-test-detail";

  final String createQuiz = "/create-question";
  final String deleteQuiz = "/delete-question";
  final String getQuizList = "/get-questions";
  final String updateQuiz = "/update-question";

}

