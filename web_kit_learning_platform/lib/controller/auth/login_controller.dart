import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/my_controller.dart';

import 'package:webkit/helpers/widgets/my_form_validator.dart';
import 'package:webkit/helpers/widgets/my_validators.dart';
import 'package:webkit/routes/app_pages.dart';
import 'package:webkit/services/apis/auth/login/models/login_request.dart';

import '../../services/apis/auth/login/login_with_phone_api.dart';

class LoginController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  bool showPassword = false, loading = false, isChecked = false;

  final String emailOrPhone = "";
  final String password = "";

  @override
  void onInit() {
    super.onInit();
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
        Get.toNamed(Routes.dashboardRoute);
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
    Get.toNamed('/auth/forgot_password');
  }

  void gotoRegister() {
    Get.offAndToNamed('/auth/register');
  }
}
