class RegisterRequest {
  String? username;
  String? fullname;
  String? email;
  String? password;
  String? serialNumber;
  String? platform;
  String? type;
  String? userType;

  RegisterRequest(
      {this.username,
        this.fullname,
        this.email,
        this.password,
        this.serialNumber,
        this.platform,
        this.type,
        this.userType});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullname = json['fullname'];
    email = json['email'];
    password = json['password'];
    serialNumber = json['serialNumber'];
    platform = json['platform'];
    type = json['type'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['fullname'] = fullname;
    data['email'] = email;
    data['password'] = password;
    data['serialNumber'] = serialNumber;
    data['platform'] = platform;
    data['type'] = type;
    data['userType'] = userType;
    return data;
  }
}
