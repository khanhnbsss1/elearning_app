class DateRequested{
  String? deviceId = "";
  int? dateStamp = 0;
  DateRequested({this.deviceId, this.dateStamp});
  DateRequested.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    dateStamp = json['dateStamp'];
  }

  DateRequested.fromJsonForDB(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    dateStamp = json['dateStamp'];
  }
  static List<int> getDateStampListByStartAndEndTime(int startTimeStampUTC,int endTimeStampUTC){
    List<int> dateStampList = List.empty(growable: true);
    DateTime startDate = DateTime.fromMillisecondsSinceEpoch(startTimeStampUTC*1000);
    DateTime endDate = DateTime.fromMillisecondsSinceEpoch(endTimeStampUTC*1000);
    DateTime startDateByDate = DateTime.utc(startDate.year, startDate.month, startDate.day);
    DateTime endDateByDate = DateTime.utc(endDate.year, endDate.month, endDate.day);

    int startDateStamp = (startDateByDate.millisecondsSinceEpoch~/1000~/3600)~/24;
    int endDateStamp = (endDateByDate.millisecondsSinceEpoch~/1000~/3600)~/24;
    for(int dateStamp = startDateStamp; dateStamp<=endDateStamp; dateStamp++)
    {
      dateStampList.add(dateStamp);
    }
    return dateStampList;
  }
  static int ConvertTimeStampUTCToDateStamp(int timeStampUTC){
    return (timeStampUTC~/3600)~/24;
  }
  static int ConvertDateStampToTimeStampUTC(int dateStamp){
    return dateStamp * 3600 *24;
  }
  static int getStartTimeStampUTCofDateStamp(int dateStamp){
    return (dateStamp) * 3600 *24;
  }
  static int getEndTimeStampUTCofDateStamp(int dateStamp){
    return (dateStamp +1) * 3600 *24 - 1;
  }
  static String getEndDateTimeStringUTOfDateStamp(int dateStamp){
    int timeUTCInsecond = (dateStamp) * 3600 *24;
    return timeUTCInsecond.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceId'] = deviceId;
    data['dateStamp'] = dateStamp;
    return data;
  }

  Map<String, dynamic> toStringInsertDB() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceId'] = deviceId;
    data['dateStamp'] = dateStamp;
    return data;
  }
}
