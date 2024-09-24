class SearchCommonRequestV2 {
  int? gradeId;
  int? categoryId;
  String? producerName;
  String? typePayment;
  String? mode;
  int? isActive;
  String? keyword;
  int? pageSize;
  int? pageNumber;

  SearchCommonRequestV2({
    this.gradeId,
    this.categoryId,
    this.producerName,
    this.typePayment,
    this.mode,
    this.isActive,
    this.keyword,
    this.pageSize,
    this.pageNumber,
  });

  SearchCommonRequestV2.fromJson(Map<String, dynamic> json) {
    gradeId = json['gradeId'];
    categoryId = json['categoryId'];
    producerName = json['producerName'];
    typePayment = json['typePayment'];
    mode = json['mode'];
    isActive = json['isActive'];
    keyword = json['keyword'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gradeId'] = gradeId;
    data['categoryId'] = categoryId;
    data['producerName'] = producerName;
    data['typePayment'] = typePayment;
    data['mode'] = mode;
    data['isActive'] = isActive??1;
    data['keyword'] = keyword ?? "";
    data['pageSize'] = pageSize;
    data['pageNumber'] = pageNumber;
    return data;
  }

  SearchCommonRequestV2 copyWith({
    int? gradeId,
    int? categoryId,
    String? producerName,
    String? typePayment,
    String? mode,
    int? isActive,
    String? keyword,
    int? pageSize,
    int? pageNumber,
  }) {
    return SearchCommonRequestV2(
      gradeId: gradeId ?? this.gradeId,
      categoryId: categoryId ?? this.categoryId,
      producerName: producerName ?? this.producerName,
      typePayment: typePayment ?? this.typePayment,
      mode: mode ?? this.mode,
      isActive: isActive ?? this.isActive,
      keyword: keyword ?? this.keyword,
      pageSize: pageSize ?? this.pageSize,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }
}
