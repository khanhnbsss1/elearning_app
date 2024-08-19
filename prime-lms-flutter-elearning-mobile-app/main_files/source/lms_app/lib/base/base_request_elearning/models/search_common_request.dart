class SearchCommonRequest {
  int? userId;
  int? pageSize;
  int? pageNumber;
  String? filterType;
  String? keyword;
  int?gradeId;
  int?producerId;
  int?categoryId;
  SearchCommonRequest(
      {
        this.userId,
        this.pageSize,
        this.pageNumber,
        this.filterType,
        this.keyword,
        this.gradeId,
        this.categoryId,
        this.producerId
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
    data['userId'] = userId;
    data['pageSize'] = pageSize;
    data['pageNumber'] = pageNumber;
    data['filterType'] = filterType??"ALL";
    data['keyword'] = keyword??"";
    data['gradeId'] = gradeId;
    data['gradeId'] = categoryId;
    data['gradeId'] = producerId;
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

    );
}
}
