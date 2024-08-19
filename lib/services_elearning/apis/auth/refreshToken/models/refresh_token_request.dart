class RefreshTokenRequest {
  String? deviceType;
  String? accessToken;
  String? refreshToken;

  RefreshTokenRequest({this.deviceType, this.accessToken, this.refreshToken});

  RefreshTokenRequest.fromJson(Map<String, dynamic> json) {
    deviceType = json['deviceType'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceType'] = deviceType;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}
