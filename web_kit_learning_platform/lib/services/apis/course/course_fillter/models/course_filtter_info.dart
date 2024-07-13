class CourseFilterListInfo {
  List<CourseFilterInfo>? data;

  CourseFilterListInfo({this.data});

  CourseFilterListInfo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CourseFilterInfo>[];
      json['data'].forEach((v) {
        data!.add(new CourseFilterInfo.fromJson(v));
      });
    }
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
  List<SubFilter>? subFilter;

  CourseFilterInfo({this.id, this.filterType, this.name, this.subFilter});

  CourseFilterInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filterType = json['filterType'];
    name = json['name'];
    if (json['sub_filter'] != null) {
      subFilter = <SubFilter>[];
      json['sub_filter'].forEach((v) {
        subFilter!.add(new SubFilter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['filterType'] = filterType;
    data['name'] = name;
    if (subFilter != null) {
      data['sub_filter'] = subFilter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubFilter {
  int? id;
  String? language;
  String? gradeName;
  String? name;

  SubFilter({this.id, this.language, this.gradeName, this.name});

  SubFilter.fromJson(Map<String, dynamic> json) {
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
