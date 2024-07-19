class AddCourseDictionary {
  String? datetime;
  String? errorCode;
  String? message;
  List<Data>? data;
  bool? success;

  AddCourseDictionary(
      {this.datetime, this.errorCode, this.message, this.data, this.success});

  AddCourseDictionary.fromJson(Map<String, dynamic> json) {
    datetime = json['datetime'];
    errorCode = json['errorCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datetime'] = this.datetime;
    data['errorCode'] = this.errorCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? filterType;
  List<SubFilter>? subFilter;

  Data({this.id, this.name, this.filterType, this.subFilter});

  Data.fromJson(Map<String, dynamic> json) {
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