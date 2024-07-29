class GetAddCourseFilterModel {
  String? datetime;
  String? errorCode;
  String? message;
  List<Filter>? data;
  bool? success;

  GetAddCourseFilterModel(
      {this.datetime, this.errorCode, this.message, this.data, this.success});

  GetAddCourseFilterModel.fromJson(dynamic json) {
      data = <Filter>[];
      json.forEach((v) {
        data!.add(new Filter.fromJson(v));
      });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Filter {
  int? id;
  String? name;
  String? filterType;
  List<SubFilter>? subFilter;

  Filter({this.id, this.name, this.filterType, this.subFilter});

  Filter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    filterType = json['filterType'];
    if (json['subFilter'] != null) {
      subFilter = <SubFilter>[];
      json['subFilter'].forEach((v) {
        subFilter!.add(new SubFilter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['filterType'] = this.filterType;
    if (this.subFilter != null) {
      data['subFilter'] = this.subFilter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubFilter {
  int? id;
  String? name;

  SubFilter({this.id, this.name});

  SubFilter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}