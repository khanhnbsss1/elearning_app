class SearchCommonRequest {
  int? userId;
  int? pageSize;
  int? pageNumber;
  String? filterType;
  String? keyword;
  int?producerId;
  String?subFilterId;
  SearchCommonRequest(
      {
        this.userId,
        this.pageSize,
        this.pageNumber,
        this.filterType,
        this.keyword,
        this.subFilterId,
        this.producerId
      });

  SearchCommonRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    filterType = json['filterType'];
    keyword = json['keyword'];
    subFilterId = json['categoryId'];
    producerId = json['producerId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['pageSize'] = pageSize;
    data['pageNumber'] = pageNumber;
    data['filterType'] = filterType??"ALL";
    data['keyword'] = keyword??"";
    data['subFilterId'] = subFilterId;
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
  }){
    return SearchCommonRequest(
      userId: userId??this.userId,
      pageSize: pageSize??this.pageSize,
      pageNumber: pageNumber??this.pageNumber,
      filterType: filterType??this.filterType,
      keyword: keyword??this.keyword,
      producerId: producerId??this.producerId,
      subFilterId: subFilterId??this.subFilterId,

    );
}
}
