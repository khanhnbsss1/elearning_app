import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:lms_app/services_elearning/apis/course/course_fillter/get_course_fillter_api.dart';
import 'package:lms_app/services_elearning/apis/course/course_fillter/models/course_filtter_info.dart';


class InstanceManager{
  static final InstanceManager _singletonBlocManager = InstanceManager._internal();
  static InstanceManager get getInstance => _singletonBlocManager;
  factory InstanceManager() {
    return _singletonBlocManager;
  }
  InstanceManager._internal();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BuildContext ?rootContext;

  bool firstLogin = true;
  bool? enableDarkMode;
  CourseFilterListInfo courseFilterListInfo = CourseFilterListInfo(data: []);
  void clearAllInstanceData()
  {
    
  }
  void onChangeCurrentUser(){
  }
  void handlerLogoutData(){
    clearAllInstanceData();
  }
  void handlerChangeCurrentUser(){
    onChangeCurrentUser();
  }
  Future<CourseFilterListInfo> getFilterCourse() async {
    if((courseFilterListInfo.data??[]).isNotEmpty) {
      return courseFilterListInfo;
    }
    GetCourseFilterApi getCourseFilterApi = GetCourseFilterApi();
    return await getCourseFilterApi.call();
    
  }
}


class TimerManager{
  static final TimerManager _singletonTimerManager = TimerManager._internal();
  static TimerManager get getInstance => _singletonTimerManager;
  factory TimerManager() {
    return _singletonTimerManager;
  }
  TimerManager._internal();
  Timer? timer, timerKeepAliveTracking;

  final String trackingTimerKey = "trackingTimerKey";

  Map<String, Timer?> timeMapManager= {

  };

  void startTimer({required String timerKey, Duration? duration, void Function(Timer)? callback}){
    stopTimer(timerKey: timerKey);
    if(timeMapManager[timerKey] == null)
    {
      timeMapManager[timerKey] = Timer.periodic(duration??const Duration(seconds: 10), callback??(timer){});
    }
  }

  void stopTimer({required String timerKey})
  {
    if(timeMapManager[timerKey]!=null)
      {
        timeMapManager[timerKey]!.cancel();
        timeMapManager[timerKey] = null;
      }
  }
}