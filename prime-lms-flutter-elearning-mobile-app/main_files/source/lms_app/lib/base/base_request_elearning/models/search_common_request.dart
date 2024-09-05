class SearchCommonRequest {
  int? userId;
  int? pageSize;
  int? pageNumber;
  String? filterType;
  String? keyword;
  int?producerId;
  String?subFilterId;
  int? isActive;
  SearchCommonRequest(
      {
        this.userId,
        this.pageSize,
        this.pageNumber,
        this.filterType,
        this.keyword,
        this.subFilterId,
        this.producerId,
        this.isActive
      });

  SearchCommonRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    filterType = json['filterType'];
    keyword = json['keyword'];
    subFilterId = json['categoryId'];
    producerId = json['producerId'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['pageSize'] = pageSize;
    data['pageNumber'] = pageNumber;
    data['filterType'] = filterType??"ALL";
    data['keyword'] = keyword??"";
    if (subFilterId != null && subFilterId != "") data['subFilterId'] = subFilterId??"";
    data['isActive'] = isActive??"1";
    return data;
  }
  SearchCommonRequest copyWith({
    int? userId,
    int? pageSize,
    int? pageNumber,
    String? filterType,
    String? keyword,
    int?producerId,
    int?categoryId,
    int?isActive,
  }){
    return SearchCommonRequest(
      userId: userId??this.userId,
      pageSize: pageSize??this.pageSize,
      pageNumber: pageNumber??this.pageNumber,
      filterType: filterType??this.filterType,
      keyword: keyword??this.keyword,
      producerId: producerId??this.producerId,
      subFilterId: subFilterId??this.subFilterId,
      isActive: isActive??this.isActive,
    );
}
}
