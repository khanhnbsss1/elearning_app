class SearchCommonRequest {
  int? userId;
  int? pageSize;
  int? pageNumber;
  String? filterType;
  String? keyword;
  int?gradeId;
  int?producerId;
  int?categoryId;
  String? userType;
  SearchCommonRequest(
      {
        this.userId,
        this.pageSize,
        this.pageNumber,
        this.filterType,
        this.keyword,
        this.gradeId,
        this.categoryId,
        this.producerId,
        this.userType
      });

  SearchCommonRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    filterType = json['filterType'];
    keyword = json['keyword'];
    gradeId = json['gradeId'];
    categoryId = json['categoryId'];
    producerId = json['producerId'];

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
    return data;
  }
  SearchCommonRequest copyWith({
    int? userId,
    int? pageSize,
    int? pageNumber,
    String? filterType,
    String? keyword,
    int?gradeId,
    int?producerId,
    int?categoryId,
    String? userType
  }){
    return SearchCommonRequest(
      userId: userId??this.userId,
      pageSize: pageSize??this.pageSize,
      pageNumber: pageNumber??this.pageNumber,
      filterType: filterType??this.filterType,
      keyword: keyword??this.keyword,
      gradeId: gradeId??this.gradeId,
      producerId: producerId??this.producerId,
      categoryId: categoryId??this.categoryId,
      userType: userType??this.userType,

    );
}
}
