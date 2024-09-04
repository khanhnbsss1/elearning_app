
import 'package:webkit/base/helper/date_time/date_time_helper.dart';

import 'package:webkit/services/apis/darh_board/request_model/dash_board_search_model.dart';
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
  List<bool>calApi = [false,false,false,false,false, false, false, false ];
  Future<void> init()async {
    
  }

  Future<SubscriptionPurchasesInfoResponseModel> getSubscriptionPurchasesInfoResponseModel() async {
    if(subscriptionPurchasesInfoResponseModel==null && calApi[0]==false)
      {
        calApi[0]==true;
        /// lay du lieu trong nam nay
        DateTime startTime = DateTime.now().copyWith(month: 0, day: 0, hour: 1);
        DateTime endTime = DateTime.now();
        String startTimeStr = DateTimeHelper.dateFormat(date: startTime, dateType: DateTimeHelper.yyyyMMDD);
        String endTimeStr = DateTimeHelper.dateFormat(date: endTime, dateType: DateTimeHelper.yyyyMMDD);

        GetSubscriptionPurchasesApi subscriptionPurchasesApi = GetSubscriptionPurchasesApi(
          dashboardSearchModel: DashboardSearchModel(
            startTime: startTimeStr,
            endTime: endTimeStr
          )
        );
        subscriptionPurchasesInfoResponseModel = await  subscriptionPurchasesApi.call();
        calApi[0]==false;
      }
    return subscriptionPurchasesInfoResponseModel!;
  }
  Future<SynthesisStudentInfoResponseModel> getSynthesisStudentInfoResponseModel() async {
    if(synthesisStudentInfoResponseModel==null && calApi[1]==false)
    {
      calApi[1]==true;
      GetDataSynthesisStudentApi subscriptionPurchasesApi = GetDataSynthesisStudentApi();
      synthesisStudentInfoResponseModel = await  subscriptionPurchasesApi.call();
      calApi[1]==false;
    }
    return synthesisStudentInfoResponseModel!;
  }

  Future<SynthesisSummaryInfo> getSynthesisInfoResponseModel() async {
    if(synthesisSummaryInfo==null && calApi[2]==false)
    {
      calApi[2]==true;
      GetDataSynthesisApi subscriptionPurchasesApi = GetDataSynthesisApi();
      synthesisSummaryInfo = await  subscriptionPurchasesApi.call();
      calApi[2]==false;
    }
    return synthesisSummaryInfo!;
  }

  Future<TopCoursesInfoResponseModel> getTopCourseReviewResponseModel() async {
    if(topCoursesInfoResponseModel==null && calApi[3]==false)
    {
      calApi[3]==true;
      GetTopCourseApi subscriptionPurchasesApi = GetTopCourseApi();
      topCoursesInfoResponseModel = await  subscriptionPurchasesApi.call();
      calApi[3]==false;
    }
    return topCoursesInfoResponseModel!;
  }

  Future<UserRegistrationInfoResponseModel> getUserRegistrationModel() async {
    if(userRegistrationInfoResponseModel==null && calApi[4]==false)
    {
      /// lay du lieu trong nam nay
      calApi[4]==true;
      DateTime startTime = DateTime.now().copyWith(month: 0, day: 0, hour: 1);
      DateTime endTime = DateTime.now();
      String startTimeStr = DateTimeHelper.dateFormat(date: startTime, dateType: DateTimeHelper.yyyyMMDD);
      String endTimeStr = DateTimeHelper.dateFormat(date: endTime, dateType: DateTimeHelper.yyyyMMDD);

      GetUserRegistrationApi subscriptionPurchasesApi = GetUserRegistrationApi(
          dashboardSearchModel: DashboardSearchModel(
              startTime: startTimeStr,
              endTime: endTimeStr
          )
      );
      userRegistrationInfoResponseModel = await  subscriptionPurchasesApi.call();
      calApi[4]==false;
    }
    return userRegistrationInfoResponseModel!;
  }

  Future<RevenueMonthResponseModel> getRevenueMonthResponseModel() async {
    if(revenueMonthResponseModel==null && calApi[5]==false)
    {
      calApi[5]==true;
      GetRevenueMonthApi response = GetRevenueMonthApi(dashboardSearchModel: DashboardSearchModel());
      revenueMonthResponseModel = await  response.call();
      calApi[5]==false;
    }
    return revenueMonthResponseModel!;
  }

  Future<RegisterMonthResponseModel> getRegisterMonthResponseModel() async {
    if(registerMonthResponseModel==null && calApi[6]==false)
    {
      calApi[6]==true;
      GetRegisterMonthApi response = GetRegisterMonthApi(dashboardSearchModel: DashboardSearchModel(limit: 12));
      registerMonthResponseModel = await  response.call();
      calApi[6]==false;
    }
    return registerMonthResponseModel!;
  }
  Future<TopCourseRevenueResponseModel> getTopCourseRevenueResponseModel() async {
    if(topCourseRevenueResponseModel==null && calApi[7]==false)
    {
      calApi[7]==true;
      GetTopCourseRevenueApi getTopCourseRevenueApi = GetTopCourseRevenueApi(dashboardSearchModel: DashboardSearchModel(limit: 10));
      topCourseRevenueResponseModel = await  getTopCourseRevenueApi.call();
      calApi[7]==false;
    }
    return topCourseRevenueResponseModel!;
  }
}