class DashboardSearchModel {
  String? startTime;
  String? endTime;
  int? limit;
  String? type;

  DashboardSearchModel({this.startTime, this.endTime, this.limit, this.type}){
    type??="DESC";
  }

  DashboardSearchModel.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
    limit = json['limit'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(startTime!=null) {
      data['startTime'] = startTime;
    }
    if(endTime!=null) {
      data['endTime'] = endTime;
    }
    if(limit!=null) {
      data['limit'] = limit;
    }
    data['type'] = type;
    return data;
  }
}
