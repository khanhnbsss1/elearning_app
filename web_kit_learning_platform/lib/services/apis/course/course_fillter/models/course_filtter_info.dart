class CourseFiltterListInfo {
  List<CourseFiltterInfo>? data;

  CourseFiltterListInfo({this.data});

  CourseFiltterListInfo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CourseFiltterInfo>[];
      json['data'].forEach((v) {
        data!.add(new CourseFiltterInfo.fromJson(v));
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

class CourseFiltterInfo {
  int? id;
  String? filtterType;
  String? name;
  List<SubFiltter>? subFiltter;

  CourseFiltterInfo({this.id, this.filtterType, this.name, this.subFiltter});

  CourseFiltterInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filtterType = json['filtterType'];
    name = json['name'];
    if (json['sub_filtter'] != null) {
      subFiltter = <SubFiltter>[];
      json['sub_filtter'].forEach((v) {
        subFiltter!.add(new SubFiltter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['filtterType'] = filtterType;
    data['name'] = name;
    if (this.subFiltter != null) {
      data['sub_filtter'] = subFiltter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubFiltter {
  int? id;
  String? language;
  String? gradeName;
  String? name;

  SubFiltter({this.id, this.language, this.gradeName, this.name});

  SubFiltter.fromJson(Map<String, dynamic> json) {
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
