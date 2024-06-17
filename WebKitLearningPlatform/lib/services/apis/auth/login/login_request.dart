class LoginRequest {
  String? username;
  String? password;
  String? serialNumber;
  String? type;

  LoginRequest({this.username, this.password, this.serialNumber, this.type});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['Username'];
    password = json['Password'];
    serialNumber = json['SerialNumber'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Username'] = username;
    data['Password'] = password;
    data['SerialNumber'] = serialNumber;
    data['Type'] = type;
    return data;
  }
}
