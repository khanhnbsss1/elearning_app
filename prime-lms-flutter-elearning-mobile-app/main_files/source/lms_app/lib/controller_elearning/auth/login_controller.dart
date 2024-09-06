import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/screens/home/home_view.dart';

import '../../base/author/user_helper.dart';
import '../../base/constant.dart';
import '../../helper/my_form_validator.dart';
import '../../helper/widget/my_validators.dart';
import '../../routes/app_pages.dart';
import '../../routes/app_routes.dart';
import '../../screens/auth/sign_up.dart';
import '../../services/apis/auth/login/login_with_phone_api.dart';
import '../../services/apis/auth/login/models/login_request.dart';
import '../../utils/next_screen.dart';
import '../my_controller.dart';

class LoginController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  bool showPassword = false,
      loading = false,
      isChecked = false,
      rememberMe = UserManager().getRememberPassword();

  String emailOrPhone = "";
  String password = "";

  String accountNearest = UserManager().getAccountLoginNearest();
  String passwordNearest = UserManager().getPasswordLoginNearest();

  @override
  Future<void> onInit() async {
    super.onInit();
    initUser();
  }

  void initUser() {
    String userName = UserManager().getAccountLoginNearest();
    emailOrPhone = userName;
    basicValidator.addField('email',
        required: true,
        label: "Email",
        validators: [MyEmailValidator()],
        controller: TextEditingController(
            text: (accountNearest != "") ? accountNearest : emailOrPhone));
    basicValidator.addField('password',
        required: true,
        label: "Password",
        validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController(
            text: (passwordNearest != "") ? passwordNearest : password));
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void onChangeCheckBox(bool? value) {
    isChecked = value ?? isChecked;
    update();
  }

  void onChangeRememberMe() {
    rememberMe = !rememberMe;
    update();
  }

  Future<bool> onLogin() async {
    LoginRequest loginRequest = LoginRequest(
      username: basicValidator.getController('email')?.text,
      password: basicValidator.getController('password')?.text,
    );
    LoginWithPhoneApi loginWithPhoneApi =
        LoginWithPhoneApi(loginRequest: loginRequest);
    bool result = await loginWithPhoneApi.call();
    if (result == true) {
      await UserManager().saveRememberPassword(rememberMe);
      if (rememberMe) {
        await UserManager().saveAccountLoginNearest(
          basicValidator.getController('email')!.text,
          basicValidator.getController('password')!.text,
        );
      } else {
        UserManager().deleteAccountNearest();
      }
      update();
      return true;
      // AppPages.route(Paths.homeScreenPath);
    } else {
      update();
      return false;
    }
  }

  void goToForgotPassword() {
    AppPages.route(Routes.homeScreenRoute);
  }

  void gotoRegister() {
    AppPages.route(Routes.homeScreenRoute);
  }
}
