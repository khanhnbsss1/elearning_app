import 'package:flutter/material.dart';
import 'package:lms_app/controller_elearning/my_controller.dart';
import 'package:lms_app/services/apis/auth/editUser/edit_user_api.dart';
import 'package:lms_app/services/apis/auth/editUser/edit_user_request.dart';

import '../../helper/my_form_validator.dart';
import '../../helper/widget/my_validators.dart';
import '../../models/user/UserProfile.dart';
import '../../services/apis/auth/register/models/register_request.dart';
import '../../services/apis/auth/register/register_with_phone_api.dart';
import '../base/author/author_manager.dart';
import '../services/apis/upload_file/models/upload_file_info.dart';
import '../services/apis/upload_file/upload_file_api.dart';
import '../services/apis/user/get_user_detail_api.dart';

class EditProfileController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  final UserProfile userProfile;
  bool showPassword = false, loading = false, isChecked = false;

  EditProfileController({required this.userProfile});

  @override
  void onInit() {
    super.onInit();
    basicValidator.addField(
      'image',
      required: true,
      label: "Image",
      validators: [MyEmailValidator()],
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'fullname',
      required: true,
      label: "Full name",
      validators: [MyEmailValidator()],
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'bank_name',
      required: true,
      label: "Bank name",
      //validators: [MyEmailValidator()],
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'bank_account',
      required: true,
      label: 'Bank account',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'password',
      required: true,
      label: 'Password',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'identity_id',
      required: true,
      label: 'Identity id',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'country_name',
      required: true,
      label: 'Country name',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'gender',
      required: true,
      label: 'Gender',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'email',
      required: true,
      label: 'Email',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'birthday',
      required: true,
      label: 'Birthday',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'file_id',
      required: true,
      label: 'File id',
      controller: TextEditingController(),
    );
    basicValidator.getController('file_id')!.text = (userProfile.fileId??0).toString();
    basicValidator.getController('gender')!.text = userProfile.gender??"";
    basicValidator.getController('email')!.text = userProfile.email??"";
    basicValidator.getController('birthday')!.text = userProfile.birthday??"";
    basicValidator.getController('image')!.text = userProfile.imageUrl??"";
    basicValidator.getController('fullname')!.text = userProfile.fullName??"";
    basicValidator.getController('bank_name')!.text = userProfile.bankName??"";
    basicValidator.getController('bank_account')!.text = userProfile.bankAccount??"";
    basicValidator.getController('identity_id')!.text = userProfile.identityId??"";
    basicValidator.getController('country_name')!.text = userProfile.countryName??"";
  }

  Future<void> updateImage(UploadFileInfo uploadFileinfo) async {
    UploadAvatarApi uploadFileApi = UploadAvatarApi(fileInfo: uploadFileinfo);
    UploadFileResponseInfo? data = await uploadFileApi.call();
  }

  void onChangeCheckBox(bool? value) {
    isChecked = value ?? isChecked;
    update();
  }

  Future<bool> onUpdate() async {
    String? birthday =  basicValidator.getController('birthday')?.text;
    birthday?.replaceAll("/", "-");
    EditUserRequest editUserRequest = EditUserRequest(
      avatar: userProfile.avatar,
      typeName: (userProfile.typeName == "" || userProfile.typeName == null) ? "User" : userProfile.typeName,
      userName: userProfile.userName??"User",
      fullname: basicValidator.getController('fullname')?.text,
      bankAccount: basicValidator.getController('bank_account')?.text,
      bankName: basicValidator.getController('bank_name')?.text,
      identityId: basicValidator.getController('identity_id')?.text,
      gender: basicValidator.getController('gender')?.text,
      birthday: birthday,
      countryName: basicValidator.getController('country_name')?.text,
      email: basicValidator.getController('email')?.text,
      phoneNumber: userProfile.phoneNumber,
      fileId: basicValidator.getController('file_id')?.text,
    );
    EditUserApi editUserApi = EditUserApi(editUserRequest: editUserRequest);
    bool data = await editUserApi.call();
    update();
    if (data == true) {
      GetUserProfileInfoApi getUserProfileInfoApi = GetUserProfileInfoApi();
      await getUserProfileInfoApi.call();
      return true;
    } else {
      return false;
      // AppPages.routeName(Routes.landingPageRoute);
    }
    update();
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void gotoLogin() {
    // AppPages.routeName(Routes.landingPageRoute);
  }
}
