import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/my_controller.dart';

import 'package:webkit/helpers/widgets/my_form_validator.dart';
import 'package:webkit/helpers/widgets/my_validators.dart';
import 'package:webkit/services/apis/auth/register/models/register_request.dart';
import 'package:webkit/services/apis/auth/register/register_with_phone_api.dart';

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
          AppPages.routeName(Routes.landingPageRoute);
        }
      loading = false;
      update();
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void gotoLogin() {
    AppPages.routeName(Routes.landingPageRoute);
  }
}
