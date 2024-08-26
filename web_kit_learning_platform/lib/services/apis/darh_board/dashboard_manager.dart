import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/helper/date_time/date_time_helper.dart';
import 'package:webkit/services/apis/category/get_category_list.dart';
import 'package:webkit/services/apis/category/models/category_info.dart';
import 'package:webkit/services/apis/course/course_fillter/get_course_fillter_api.dart';
import 'package:webkit/services/apis/course/course_fillter/models/course_filtter_info.dart';
import 'package:webkit/services/apis/course/get_course_dictionary/get_course_directory_api.dart';
import 'package:webkit/services/apis/course/get_course_dictionary/get_course_directory_model.dart';
import 'package:webkit/services/apis/darh_board/request_model/dash_board_search_model.dart';
import 'package:webkit/services/apis/grade/get_grade_list.dart';
import 'package:webkit/services/apis/grade/models/grade_info.dart';

import '../../../base/widgets/widget_common/widget_with_title_common.dart';
import 'get_data_synthesis_api.dart';
import 'get_data_synthesis_students_api.dart';
import 'get_subscription_purchases_api.dart';
import 'get_top-courses_api.dart';
import 'get_user-registration_api.dart';
import 'models/subscription_purchases_info.dart';
import 'models/synthesisInfo.dart';
import 'models/synthesis_students_info.dart';
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
  UserRegistrationInfoResponseModel? userRegistrationInfoResponseModel;
  List<bool>calApi = [false,false,false,false,false, ];
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

  Future<TopCoursesInfoResponseModel> getTopCourseResponseModel() async {
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
}