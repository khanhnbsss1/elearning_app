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
        this.isActive
      });

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
    if(keyword!=null)
    {
      data['keyword'] = keyword;
    }
    if(gradeId!=null)
    {
      data['gradeId'] = gradeId;
    }
    if(categoryId!=null)
    {
      data['categoryId'] = categoryId;
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
    bool? isActive
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
    );
}
}
