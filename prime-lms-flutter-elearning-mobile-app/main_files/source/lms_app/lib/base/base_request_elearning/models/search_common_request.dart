class SearchCommonRequest {
  int? userId;
  int? pageSize;
  int? pageNumber;
  int? testId;
  String? filterType;
  String? keyword;
  int?producerId;
  String?subFilterId;
  int? isActive;
  String? type;
  SearchCommonRequest(
      {
        this.userId,
        this.pageSize,
        this.pageNumber,
        this.testId,
        this.filterType,
        this.keyword,
        this.subFilterId,
        this.producerId,
        this.isActive,
        this.type
      });

  SearchCommonRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    testId = json['testId'];
    filterType = json['filterType'];
    keyword = json['keyword'];
    subFilterId = json['categoryId'];
    producerId = json['producerId'];
    isActive = json['isActive'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['pageSize'] = pageSize;
    data['pageNumber'] = pageNumber;
    if (testId != null) data['testId'] = testId;
    data['filterType'] = filterType??"ALL";
    data['keyword'] = keyword??"";
    if (subFilterId != null && subFilterId != "") data['subFilterId'] = subFilterId??"";
    data['isActive'] = isActive??"1";
    if (producerId != null) data['producerId'] = producerId??"";
    if (type != null) data['type'] = type;
    return data;
  }
  SearchCommonRequest copyWith({
    int? userId,
    int? pageSize,
    int? pageNumber,
    int? testId,
    String? filterType,
    String? keyword,
    int? producerId,
    int? categoryId,
    int? isActive,
    String? type,
  }){
    return SearchCommonRequest(
      userId: userId??this.userId,
      pageSize: pageSize??this.pageSize,
      pageNumber: pageNumber??this.pageNumber,
      testId: testId??this.testId,
      filterType: filterType??this.filterType,
      keyword: keyword??this.keyword,
      producerId: producerId??this.producerId,
      subFilterId: subFilterId??this.subFilterId,
      isActive: isActive??this.isActive,
        type: type??this.type
    );
}
}
