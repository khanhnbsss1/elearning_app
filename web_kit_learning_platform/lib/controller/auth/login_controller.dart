import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/biomectric/IdentifierConst.dart';
import 'package:webkit/controller/my_controller.dart';

import 'package:webkit/helpers/widgets/my_form_validator.dart';
import 'package:webkit/helpers/widgets/my_validators.dart';
import 'package:webkit/routes/app_pages.dart';
import 'package:webkit/services/apis/auth/login/models/login_request.dart';

import '../../services/apis/auth/login/login_with_phone_api.dart';

class LoginController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  bool showPassword = false, loading = false, isChecked = false;

  String emailOrPhone = "";
  String password = "";

  @override
  Future<void> onInit() async {
    super.onInit();
    String userName=  await UserManager().getAccountLoginNearest();
    emailOrPhone = userName;
    basicValidator.addField('email',
        required: true,
        label: "Email",
        validators: [MyEmailValidator()],
        controller: TextEditingController(text: emailOrPhone));

    basicValidator.addField('password',
        required: true,
        label: "Password",
        validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController(text: password));
  }
  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void onChangeCheckBox(bool? value) {
    isChecked = value ?? isChecked;
    update();
  }

  Future<void> onLogin() async {
    LoginRequest loginRequest = LoginRequest(
      username: basicValidator.getController('email')?.text,
      password: basicValidator.getController('password')?.text,);
      loading = true;
      update();
      LoginWithPhoneApi loginWithPhoneApi = LoginWithPhoneApi(loginRequest: loginRequest);
      bool result = await loginWithPhoneApi.call();
      if(result == true)
      {
        if(isChecked)
        {
          await UserManager().saveAccountLoginNearest(IdentifierConst.username);
        }
        AppPages.routeName(Routes.dashboardRoute);
      }
      else
      {
        basicValidator.validateForm();
        basicValidator.clearErrors();
        ToastUtils.showToastError(S.of(Get.context!).email_or_pass_invalid);
      }
     // loading = false;
     // update();
  }

  void goToForgotPassword() {
    AppPages.routeName('/auth/forgot_password');
  }

  void gotoRegister() {
    AppPages.routeName('/auth/register');
  }
}
