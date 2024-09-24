
import 'package:webkit/base/helper/date_time/date_time_helper.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/services/apis/course/course_list/course_api.dart';
import 'package:webkit/services/apis/course/course_list/course_interest_api.dart';
import 'package:webkit/services/apis/course/course_list/models/course_models.dart';
import 'package:webkit/services/apis/course/my_course_list/my_course_api.dart';

import 'package:webkit/services/apis/darh_board/revenue_month_api.dart';
import 'get_data_synthesis_api.dart';
import 'get_data_synthesis_students_api.dart';
import 'get_register_month_api.dart';
import 'get_subscription_purchases_api.dart';
import 'get_top-courses_api.dart';
import 'get_top_course_revenue_api.dart';
import 'get_user-registration_api.dart';
import 'models/register_month_info.dart';
import 'models/revenue_month_info.dart';
import 'models/subscription_purchases_info.dart';
import 'models/synthesisInfo.dart';
import 'models/synthesis_students_info.dart';
import 'models/top_course_revenue_info.dart';
import 'models/top_courses_info.dart';
import 'models/user_registration_info.dart';

class DashboardManager{
  static final DashboardManager _singletonDashboardManager = DashboardManager._internal();
  static DashboardManager get getInstance => _singletonDashboardManager;
  factory DashboardManager() {
    return _singletonDashboardManager;
  }
  
  DashboardManager._internal();

  SubscriptionPurchasesInfoResponseModel? subscriptionPurchasesInfoResponseModel;
  SynthesisStudentInfoResponseModel? synthesisStudentInfoResponseModel;
  SynthesisSummaryInfo? synthesisSummaryInfo;
  TopCoursesInfoResponseModel? topCoursesInfoResponseModel;
  TopCourseRevenueResponseModel? topCourseRevenueResponseModel;
  UserRegistrationInfoResponseModel? userRegistrationInfoResponseModel;
  RevenueMonthResponseModel? revenueMonthResponseModel;
  RegisterMonthResponseModel?registerMonthResponseModel;
  CourseResponseModel?courseCareResponseModel, courseAllResponseModel, courseRegistedResponseModel;
  List<bool>calApi = [false,false,false,false,false, false, false, false, false, false, false ];
  Future<void> init()async {
    
  }

  Future<SubscriptionPurchasesInfoResponseModel> getSubscriptionPurchasesInfoResponseModel() async {
    if(subscriptionPurchasesInfoResponseModel==null && calApi[0]==false)
      {
        calApi[0]=true;
        /// lay du lieu trong nam nay
        DateTime startTime = DateTime.now().copyWith(month: 0, day: 0, hour: 1);
        DateTime endTime = DateTime.now();
        String startTimeStr = DateTimeHelper.dateFormat(date: startTime, dateType: DateTimeHelper.yyyyMMDD);
        String endTimeStr = DateTimeHelper.dateFormat(date: endTime, dateType: DateTimeHelper.yyyyMMDD);

        GetSubscriptionPurchasesApi subscriptionPurchasesApi = GetSubscriptionPurchasesApi(
          dashboardSearchModel: SearchCommonRequest(
            startDate: startTimeStr,
            endDate: endTimeStr
          )
        );
        subscriptionPurchasesInfoResponseModel = await  subscriptionPurchasesApi.call();
        calApi[0]=false;
      }
    return subscriptionPurchasesInfoResponseModel!;
  }
  Future<SynthesisStudentInfoResponseModel> getSynthesisStudentInfoResponseModel() async {
    if(synthesisStudentInfoResponseModel==null && calApi[1]==false)
    {
      calApi[1]=true;
      GetDataSynthesisStudentApi subscriptionPurchasesApi = GetDataSynthesisStudentApi();
      synthesisStudentInfoResponseModel = await  subscriptionPurchasesApi.call();
      calApi[1]=false;
    }
    return synthesisStudentInfoResponseModel!;
  }

  Future<SynthesisSummaryInfo> getSynthesisInfoResponseModel() async {
    if(synthesisSummaryInfo==null && calApi[2]==false)
    {
      calApi[2]=true;
      GetDataSynthesisApi subscriptionPurchasesApi = GetDataSynthesisApi();
      synthesisSummaryInfo = await  subscriptionPurchasesApi.call();
      calApi[2]=false;
    }
    return synthesisSummaryInfo!;
  }

  Future<TopCoursesInfoResponseModel> getTopCourseReviewResponseModel() async {
    if(topCoursesInfoResponseModel==null && calApi[3]==false)
    {
      calApi[3]=true;
      GetTopCourseApi subscriptionPurchasesApi = GetTopCourseApi();
      topCoursesInfoResponseModel = await  subscriptionPurchasesApi.call();
      calApi[3]=false;
    }
    return topCoursesInfoResponseModel!;
  }

  Future<UserRegistrationInfoResponseModel> getUserRegistrationModel() async {
    if(userRegistrationInfoResponseModel==null && calApi[4]==false)
    {
      /// lay du lieu trong nam nay
      calApi[4]=true;
      DateTime startTime = DateTime.now().copyWith(month: 0, day: 0, hour: 1);
      DateTime endTime = DateTime.now();
      String startTimeStr = DateTimeHelper.dateFormat(date: startTime, dateType: DateTimeHelper.yyyyMMDD);
      String endTimeStr = DateTimeHelper.dateFormat(date: endTime, dateType: DateTimeHelper.yyyyMMDD);

      GetUserRegistrationApi subscriptionPurchasesApi = GetUserRegistrationApi(
          dashboardSearchModel: SearchCommonRequest(
              startTime: startTimeStr,
              endTime: endTimeStr
          )
      );
      userRegistrationInfoResponseModel = await  subscriptionPurchasesApi.call();
      calApi[4]=false;
    }
    return userRegistrationInfoResponseModel!;
  }

  Future<RevenueMonthResponseModel> getRevenueMonthResponseModel() async {
    if(revenueMonthResponseModel==null && calApi[5]==false)
    {
      calApi[5]=true;
      GetRevenueMonthApi response = GetRevenueMonthApi(dashboardSearchModel: SearchCommonRequest());
      revenueMonthResponseModel = await  response.call();
      calApi[5]=false;
    }
    return revenueMonthResponseModel!;
  }

  Future<RegisterMonthResponseModel> getRegisterMonthResponseModel() async {
    if(registerMonthResponseModel==null && calApi[6]==false)
    {
      calApi[6]=true;
      GetRegisterMonthApi response = GetRegisterMonthApi(dashboardSearchModel: SearchCommonRequest(limit: 12));
      registerMonthResponseModel = await  response.call();
      calApi[6]=false;
    }
    return registerMonthResponseModel!;
  }
  Future<TopCourseRevenueResponseModel> getTopCourseRevenueResponseModel() async {
    if(topCourseRevenueResponseModel==null && calApi[7]==false)
    {
      calApi[7]=true;
      GetTopCourseRevenueApi getTopCourseRevenueApi = GetTopCourseRevenueApi(dashboardSearchModel: SearchCommonRequest(limit: 10));
      topCourseRevenueResponseModel = await  getTopCourseRevenueApi.call();
      calApi[7]=false;
    }
    return topCourseRevenueResponseModel!;
  }

  Future<CourseResponseModel> getCourseCareListResponseModel() async {
    if(courseCareResponseModel==null && calApi[8]==false)
    {
      calApi[8]=true;
      SearchCommonRequest? searchCommonRequest= SearchCommonRequest(limit: 20);
      GetCourseInterestListApi courseApi = GetCourseInterestListApi(searchCommonRequest: searchCommonRequest);
      courseCareResponseModel = await courseApi.call();
      calApi[8]=false;
    }
    return courseCareResponseModel!;
  }

  Future<CourseResponseModel> getCourseListAllResponseModel() async {
    if(courseAllResponseModel==null && calApi[9]==false)
    {
      calApi[9]=true;
      SearchCommonRequest? searchCommonRequest= SearchCommonRequest(filterType: "ALL", pageNumber: 0, pageSize: 20, keyword: "", isActive: true);
      GetCourseListApi courseApi = GetCourseListApi(searchCommonRequest: searchCommonRequest);
      courseAllResponseModel = await courseApi.call();
      calApi[9]=false;
    }
    return courseAllResponseModel!;
  }

  Future<CourseResponseModel> getCourseListRegistedResponseModel() async {
    if(courseRegistedResponseModel==null && calApi[10]==false)
    {
      calApi[10]=true;
      SearchCommonRequest? searchCommonRequest= SearchCommonRequest(filterType: "ALL", pageNumber: 0, pageSize: 20, keyword: "", isActive: true);
      MyCourseApi courseApi = MyCourseApi(searchCommonRequest: searchCommonRequest);
      courseRegistedResponseModel = await courseApi.call();
      calApi[10]=false;
    }
    return courseRegistedResponseModel!;
  }
}