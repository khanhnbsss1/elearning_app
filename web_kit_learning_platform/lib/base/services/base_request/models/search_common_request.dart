class SearchCommonRequest {
  int? userId;
  int? pageSize;
  int? pageNumber;
  String? filterType;
  int? subFilter;
  String? keyword;
  int?gradeId;
  int?producerId;
  int?categoryId;
  String? userType;
  bool? isActive;
  String? startDate;
  String? endDate;
  String?status;
  
  String? startTime;
  String? endTime;
  int? limit;
  String? type;
  String?roleId;
  int?courseId;
  String? vocabularyType;
  String? mode;
  String?producerName;
  SearchCommonRequest(
      {
        this.userId,
        this.pageSize,
        this.pageNumber,
        this.filterType,
        this.subFilter,
        this.keyword,
        this.gradeId,
        this.categoryId,
        this.producerId,
        this.userType,
        this.isActive,
        this.endDate,
        this.startDate,
        this.status,
        this.type, 
        this.limit,
        this.startTime,
        this.endTime,
        this.roleId,
        this.courseId,
        this.vocabularyType,
        this.mode,
        this.producerName
      }){
    type??="DESC";
  }

  SearchCommonRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    filterType = json['filterType'];
    subFilter = json['subFilter'];

    keyword = json['keyword'];
    gradeId = json['gradeId'];
    categoryId = json['categoryId'];
    producerId = json['producerId'];
    isActive = json['isActive'];
    courseId = json['courseId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(userId!=null)
      {
        data['userId'] = userId;
      }

    if(pageSize!=null)
    {
      data['pageSize'] = pageSize;
    }

    if(pageNumber!=null)
    {
      data['pageNumber'] = pageNumber;
    }
    if(filterType!=null)
    {
      data['filterType'] = filterType;
    }
    if(subFilter!=null)
    {
      data['subFilterId'] = subFilter;
    }
    if(keyword!=null && keyword!.isNotEmpty)
    {
      data['keyword'] = keyword;
      data['userName'] = keyword;
    }
    if(gradeId!=null)
    {
      data['gradeId'] = gradeId;
      data['grade_id'] = gradeId;
    }
    if(categoryId!=null)
    {
      data['categoryId'] = categoryId;
      data['category_id'] = categoryId;
    }
    if(producerId!=null)
    {
      data['producerId'] = producerId;
    }
    if(userType!=null)
    {
      data['typeName'] = userType;
    }
    if(isActive!=null)
    {
      data['isActive'] = (isActive??true)?1:0;
    }
    if(startDate!=null)
    {
      data['startDate'] = startDate;
      data['dateTo'] = startDate;
    }
    if(startTime!=null)
    {
      data['startTime'] = startTime;
    }
    if(endDate!=null)
    {
      data['endDate'] = endDate;
      data['dateEnd'] = endDate;
    }
    if(endTime!=null)
    {
      data['endTime'] = endTime;
    }
    if(status!=null)
    {
      data['status'] = status;
    }
    data['type'] = type;
    if(vocabularyType!=null)
      {
        data['type'] = (vocabularyType??"").isNotEmpty?vocabularyType:null;
      }
    if(limit!=null) {
      data['limit'] = limit;
    }
    if((roleId??'').isNotEmpty) {
      data['roleId'] = roleId;
    }
    if(courseId!=null) {
      data['courseId'] = courseId;
    }
    if((mode??'').isNotEmpty) {
      data['mode'] = mode;
    }
    if((producerName??'').isNotEmpty) {
      data['producerName'] = producerName;
    }
    return data;
  }
  SearchCommonRequest copyWith({
    int? userId,
    int? pageSize,
    int? pageNumber,
    String? filterType,
    int? subFilter,
    String? keyword,
    int?gradeId,
    int?producerId,
    int?categoryId,
    String? userType,
    bool? isActive,
    String? startDate,
    String? endDate,
    String?status,
    String?roleId,
    String? type,
    String? vocabularyType,
    String? mode,
    String?producerName
  }){
    return SearchCommonRequest(
      userId: userId??this.userId,
      pageSize: pageSize??this.pageSize,
      pageNumber: pageNumber??this.pageNumber,
      filterType: filterType??this.filterType,
      subFilter: subFilter, /// tuy loai filterType moi có subFilter
      keyword: keyword??this.keyword,
      gradeId: gradeId??this.gradeId,
      producerId: producerId??this.producerId,
      categoryId: categoryId??this.categoryId,
      userType: userType??this.userType,
      isActive: isActive??this.isActive,
      startDate: startDate??this.startDate,
      endDate: endDate??this.endDate,
      status: status??this.status,
      roleId: roleId??this.roleId,
      type: type??this.type,
      vocabularyType: vocabularyType??this.vocabularyType,
      mode: mode??this.mode,
      producerName: producerName??this.producerName,
    );
}
}
