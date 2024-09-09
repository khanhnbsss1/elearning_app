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
  final String updatePassword = "/update-passwword";
  
  
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
  final String registerCourse = "/regist-course";

  ///Lesson
  final String getLessonListFilter = "/get-list-filter";
  final String createLesson = "/create-lecture";
  final String deleteLesson = "/delete-lecture";
  final String updateLesson = "/update-lecture";
  final String getDetailLesson = "/get-detail";
  final String linkLesson = "/Link-lecture-course";
  final String unlinkLesson = "/unlink-lecture-course";
  final String getLessonList = "/get-list";
  final String updateLessonStatus = "/update-status";
  final String getLecturesFilter = "/filter-lectures-directory";

  /// landing page

  final String getCourseListLandingPage = "/get-landingpage-course";
  final String getTeacherListLandingPage = "/get-landingpage-teacher";
  final String getReviewListLandingPage = "/get-landingpage-review";

  final String createLandingPageReview = "/create-landingpage-review";
  final String updateLandingPageReview = "/update-landingpage-review";
  final String deleteLandingPageReview = "/delete-landingpage-review";
  /// thong tin nguoi dung
  final String createUser = "/register-role";
  final String editUser = "/edit-user";
  final String deleteUser = "/delete-account";

  final String getUserDetail = "/get-user";
  final String getUserList = "/get-user-list";

 /// them tu dien
  final String addVocabulary = "/create-vocabulary";
  final String getListVocabulary = "/get-list";
  final String updateVocabulary = "/update-vocabulary";
  final String linkVocabulary = "/link-vocabulary";
  final String unlinkVocabulary = "/unlink-multiple-vocabulary";
  final String deleteVocabulary = "/delete-vocabulary";
  final String getVocabularyDetail = "/get-vocabulary-detail";

  /// file
  final String addUploadFile = "/upload-file";
  final String addUploadMultiFile = "/upload-multiple-file";

  ///tag
  final String getTagsList = "/get-tags";
  final String createTag = "/create-tag";
  final String updateTag = "/update-tag";
  final String deleteTag = "/delete-tag";

  ///category
  final String getCategories = "/get-categories";
  final String createCategory = "/create-category";
  final String updateCategory = "/update-category";
  final String deleteCategory = "/delete-category";
  ///category
  final String getGradeList = "/get-grades";
  final String createGrade = "/create-grade";
  final String updateGrade = "/update-grade";
  final String deleteGrade = "/delete-grade";
  ///test
  final String getTestList = "/get-tests";
  final String createTest = "/create-test";
  final String updateTest = "/update-test";
  final String deleteTest = "/delete-test";
  final String detailTest = "/get-test-detail";
  final String getTestFilter = "/filter-tests-directory";


  final String createQuiz = "/create-question";
  final String deleteQuiz = "/delete-question";
  final String getQuizList = "/get-questions";
  final String updateQuiz = "/update-question";
  final String linkTestToLesson = "/link-lecture-test";
  final String unLinkTestFromLesson = "/unlink-lecture-test";
  final String linkTestToCourse = "/link-course-test";
  final String unLinkTestFromCourse = "/unlink-course-test";
  final String getQuizFilter = "/filter-quizs-directory";

  /// score
  final String createScore = "/create_score";
  
  /// dashboard
  final String getDataSynthesis = "/get-data-synthesis";
  final String getDataSynthesisStudent = "/get-data-synthesis-students";
  final String getLastReview = "/lastest-review";
  final String getSubscriptionPurchases = "/subscription-purchases";
  final String getTopCourses = "/top-courses";
  final String getUserRegistration = "/user-registration";

  final String getTopCourseRevenue = "/top-course-revenue"; ///top khóa học có doanh thu cao nhất -
  final String getTopCourseUser = "/top-course-user"; ///Top khóa học có người học cao nhất
  
  /// report
  final String getRevenueHistory = "/revenue-history";/// Doanh thu theo tháng, grade, category, - 
  final String getRegisterMonth= "/register-month";///Số người đăng ký mới theo các tháng -
  final String getCourseRegistrationHistory = "/course-registration-history";///Lịch sử đăng ký khóa học theo khoảng thời gian 
  final String getCourseHistory = "/course-history"; ///Lịch sửa tạo/sửa khóa học theo khoảng thời gian
  final String getRegisterTimePeriod = "/register-time-period"; /// Người đăng ký mới theo khoảng thời gian - 

  
  final String getRevenueMonth = "/revenue-month";/// Doanh thu  theo các tháng



  /// permisison
  final String getUserPermissionList = "/get-role-claims";
  final String addPermissionListToRole = "/add-group-claims";
  final String deletePermissionListFromRole = "/delete-group-claim";

  /// roles
  final String getUserRolesList = "/get-roles";
  final String addRoles = "/create-role";
  final String editRoles = "/edit-role";
  final String deleteRoles = "/delete-role";
  final String editUserRoles = "/edit-user-role";

  
  /// payment
  final String unlockCourse = "/unlock-course";
  final String getRequests = "/get-requests";
  



}

