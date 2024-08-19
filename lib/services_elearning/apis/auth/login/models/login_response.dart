class AuthInfo {
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  int? expireAt;

  AuthInfo(
      {
        this.accessToken, 
        this.refreshToken, 
        this.tokenType, 
        this.expireAt
      });

  AuthInfo.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
    expireAt = json['expire_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['token_type'] = tokenType;
    data['expire_at'] = expireAt;
    return data;
  }

  AuthInfo copyWith(
  {String? accessToken,
    String? refreshToken,
    String? tokenType,
    int? expireAt}){
    return AuthInfo(
      refreshToken: refreshToken??this.refreshToken,
      accessToken: accessToken??this.accessToken,
      tokenType: tokenType??this.tokenType,
      expireAt: expireAt??this.expireAt,
    );
  }
}
