class DashboardSearchModel {
  String? startTime;
  String? endTime;
  int? limit;
  String? type;

  int? categoryId;
  int? gradeId;
  int? pageSize;
  int? pageNumber;
  DashboardSearchModel(
  {
    this.startTime, this.endTime, this.limit, this.type,
    this.categoryId, this.gradeId, this.pageSize, this.pageNumber
  }){
    type??="DESC";
  }

  DashboardSearchModel.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
    limit = json['limit'];
    type = json['type'];
    categoryId = json['category_id'];
    gradeId = json['grade_id'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(startTime!=null) {
      data['startTime'] = startTime;
      data['dateTo'] = startTime;

    }
    if(endTime!=null) {
      data['endTime'] = endTime;
      data['dateEnd'] = endTime;

    }
    if(limit!=null) {
      data['limit'] = limit;
    }
    data['type'] = type;

    if(categoryId!=null) {
      data['category_id'] = categoryId;
    }
    if(gradeId!=null) {
      data['grade_id'] = gradeId;
    }
    if(pageSize!=null) {
      data['pageSize'] = pageSize;
    }
    if(pageNumber!=null) {
      data['pageNumber'] = pageNumber;
    }
    return data;
  }
}
