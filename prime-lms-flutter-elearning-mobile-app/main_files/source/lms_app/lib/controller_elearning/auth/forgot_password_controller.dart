import 'package:flutter/material.dart';

import '../../helper/my_form_validator.dart';
import '../../helper/widget/my_validators.dart';
import '../../routes/app_pages.dart';
import '../my_controller.dart';


class ForgotPasswordController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  bool showPassword = false, loading = false;

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
  }

  Future<void> onLogin() async {
    if (basicValidator.validateForm()) {
      loading = true;
      update();
      var errors;
      AppPages.route('/auth/reset_password');
      loading = false;
      update();
    }
  }

  // void gotoLogIn() {
  //   AppPages.route(Routes.loginRoute);
  // }
}
