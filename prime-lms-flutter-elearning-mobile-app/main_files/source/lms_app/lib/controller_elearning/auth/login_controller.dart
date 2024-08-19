import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/screens/home/home_view.dart';

import '../../base/author/user_helper.dart';
import '../../base/constant.dart';
import '../../helper_elearning/my_form_validator.dart';
import '../../helper_elearning/widget/my_validators.dart';
import '../../routes/app_pages.dart';
import '../../routes/app_routes.dart';
import '../../screens/auth/sign_up.dart';
import '../../services_elearning/apis/auth/login/login_with_phone_api.dart';
import '../../services_elearning/apis/auth/login/models/login_request.dart';
import '../../utils/next_screen.dart';
import '../my_controller.dart';


class LoginController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  bool showPassword = false, loading = false, isChecked = false;

  String emailOrPhone = "";
  String password = "";

  @override
  Future<void> onInit() async {
    super.onInit();
    initUser();
  }
  void initUser() {
    String userName=  UserManager().getAccountLoginNearest();
    emailOrPhone = userName;
    basicValidator.addField('email',
        required: true,
        label: "Email",
        validators: [MyEmailValidator()],
        controller: TextEditingController(text: (kDebugMode) ? "0348074377" : emailOrPhone));
    basicValidator.addField('password',
        required: true,
        label: "Password",
        validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController(text: (kDebugMode) ? "Ll@123456" : password));
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
        AppPages.route(Paths.homeScreenPath);
      }
      else
      {
        // basicValidator.clearErrors();
      }
    loading = false;
    update();
  }

  void goToForgotPassword() {
    AppPages.route(Routes.homeScreenRoute);
  }

  void gotoRegister() {
    AppPages.route(Routes.homeScreenRoute);
  }
}
