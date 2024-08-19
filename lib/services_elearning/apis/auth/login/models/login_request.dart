class LoginRequest {
  String? username;
  String? password;
  String? serialNumber;
  String? type;
  String? platform;
  LoginRequest({this.username, this.password, this.serialNumber, this.type, this.platform});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['Username'];
    password = json['Password'];
    serialNumber = json['SerialNumber'];
    type = json['Type'];
    platform = json['platform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Username'] = username;
    data['Password'] = password;
    data['SerialNumber'] = serialNumber;
    data['Type'] = type;
    data['platform'] = platform;
    return data;
  }
}
