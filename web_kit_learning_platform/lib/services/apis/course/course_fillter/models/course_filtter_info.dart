class CourseFilterListInfo {
  List<CourseFilterInfo>? data;

  CourseFilterListInfo({this.data}){
    data??=[];
  }

  CourseFilterListInfo.fromJson(dynamic json) {
      data = <CourseFilterInfo>[];
      json.forEach((v) {
        data!.add(new CourseFilterInfo.fromJson(v));
      });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataOutput = <String, dynamic>{};
    if (data != null) {
      dataOutput['data'] = data!.map((v) => v.toJson()).toList();
    }
    return dataOutput;
  }
}

class CourseFilterInfo {
  int? id;
  String? filterType;
  String? name;
  SubFilterInfo? selectSubFilter;/// bien them vao de chon luc chon
  List<SubFilterInfo>? subFilter;

  CourseFilterInfo({this.id, this.filterType, this.name, this.subFilter, this.selectSubFilter});

  CourseFilterInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filterType = json['filterType'];
    name = json['name'];
    if (json['subFilter'] != null) {
      subFilter = <SubFilterInfo>[];
      json['subFilter'].forEach((v) {
        subFilter!.add(new SubFilterInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['filterType'] = filterType;
    data['name'] = name;
    if (subFilter != null) {
      data['subFilter'] = subFilter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubFilterInfo {
  int? id;
  String? language;
  String? gradeName;
  String? name;

  SubFilterInfo({this.id, this.language, this.gradeName, this.name});

  SubFilterInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    language = json['language'];
    gradeName = json['grade_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['language'] = language;
    data['grade_name'] = gradeName;
    data['name'] = name;
    return data;
  }
}
