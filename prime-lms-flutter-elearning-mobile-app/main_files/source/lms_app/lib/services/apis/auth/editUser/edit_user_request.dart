class EditUserRequest {
  String? avatar;
  String? userName;
  String? fullname;
  String? bankAccount;
  String? bankName;
  String? identityId;
  String? gender;
  String? birthday;
  String? phoneNumber;
  String? typeName;

  EditUserRequest(
      {this.avatar,
        this.userName,
        this.fullname,
        this.bankAccount,
        this.bankName,
        this.identityId,
        this.gender,
        this.birthday,
        this.phoneNumber,
        this.typeName});

  EditUserRequest.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    userName = json['user_name'];
    fullname = json['fullname'];
    bankAccount = json['bank_account'];
    bankName = json['bank_name'];
    identityId = json['identity_id'];
    gender = json['gender'];
    birthday = json['birthday'];
    phoneNumber = json['phone_number'];
    typeName = json['type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['user_name'] = userName;
    data['fullname'] = fullname;
    data['bank_account'] = bankAccount;
    data['bank_name'] = bankName;
    data['identity_id'] = identityId;
    data['gender'] = gender;
    data['birthday'] = birthday;
    data['phone_number'] = phoneNumber;
    data['type_name'] = typeName;
    return data;
  }
}