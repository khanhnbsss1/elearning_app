class CreateRoleRequestInfo {
  String? roleName;
  List<Claims>? claims;

  CreateRoleRequestInfo({this.roleName, this.claims});

  CreateRoleRequestInfo.fromJson(Map<String, dynamic> json) {
    roleName = json['roleName'];
    if (json['claims'] != null) {
      claims = <Claims>[];
      json['claims'].forEach((v) {
        claims!.add(new Claims.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roleName'] = roleName;
    if (claims != null) {
      data['claims'] = claims!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Claims {
  String? type;
  String? value;

  Claims({this.type, this.value});

  Claims.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    return data;
  }
}
