class CreateRoleRequestInfo {
  String? roleName;

  CreateRoleRequestInfo({this.roleName,});

  CreateRoleRequestInfo.fromJson(Map<String, dynamic> json) {
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roleName'] = roleName;
    return data;
  }
}

class UpdateRoleRequestInfo {
  String? roleId;
  String? newRole;

  UpdateRoleRequestInfo({this.roleId, this.newRole});

  UpdateRoleRequestInfo.fromJson(Map<String, dynamic> json) {
    roleId = json['roleId'];
    newRole = json['newRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roleId'] = roleId;
    data['newRole'] = newRole;
    return data;
  }
}
