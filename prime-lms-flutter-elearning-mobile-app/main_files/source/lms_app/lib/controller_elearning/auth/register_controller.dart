import 'package:flutter/material.dart';
import 'package:lms_app/controller_elearning/my_controller.dart';
import 'package:lms_app/helper_elearning/my_form_validator.dart';
import 'package:lms_app/helper_elearning/widget/my_validators.dart';
import 'package:lms_app/models/user/UserProfile.dart';
import 'package:lms_app/services_elearning/apis/auth/register/models/register_request.dart';
import 'package:lms_app/services_elearning/apis/auth/register/register_with_phone_api.dart';

import '../../base/base.export.dart';

class RegisterController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();

  bool showPassword = false, loading = false, isChecked = false;
  @override
  void onInit() {
    super.onInit();
    basicValidator.addField(
      'email',
      required: true,
      label: "Email",
      validators: [MyEmailValidator()],
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'phone',
      required: true,
      label: "phone",
      //validators: [MyEmailValidator()],
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'first_name',
      required: true,
      label: 'First Name',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'last_name',
      required: true,
      label: 'Last Name',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'password',
      required: true,
      validators: [MyLengthValidator(min: 6, max: 10)],
      controller: TextEditingController(),
    );
  }

  void onChangeCheckBox(bool? value) {
    isChecked = value ?? isChecked;
    update();
  }
  Future<void> onRegister() async {
    RegisterRequest registerRequest = RegisterRequest(
      username: basicValidator.getController('phone')?.text,
      password: basicValidator.getController('password')?.text,
      email: basicValidator.getController('email')?.text,
      fullname: "${basicValidator.getController('first_name')?.text} ${basicValidator.getController('last_name')?.text}",
      userType: userTypeToStr[isChecked?UserType.Teacher: UserType.User]
    );
    RegisterWithPhoneApi registerWithPhoneApi = RegisterWithPhoneApi(registerRequest: registerRequest);
    dynamic data= await registerWithPhoneApi.call();
      loading = true;
      update();
      if (data != true) {
        basicValidator.clearErrors();
      }
      else
        {
          AppPages.route(Routes.landingPageRoute);
        }
      loading = false;
      update();
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void gotoLogin() {
    AppPages.route(Routes.landingPageRoute);
  }
}
