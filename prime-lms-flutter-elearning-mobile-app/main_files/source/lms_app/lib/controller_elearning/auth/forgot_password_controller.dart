import 'package:flutter/material.dart';
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/controller_elearning/my_controller.dart';
import 'package:lms_app/helper_elearning/my_form_validator.dart';
import 'package:lms_app/helper_elearning/widget/my_validators.dart';


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

  void gotoLogIn() {
    AppPages.route(Routes.loginRoute);
  }
}
