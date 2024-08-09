import 'package:flutter/cupertino.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/helpers/widgets/my_form_validator.dart';

class EditProfileController extends MyController {
  MyFormValidator validation = MyFormValidator();
  bool showPassword = false;

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void onInit() {
    super.onInit();
    validation.addField(
      'fullName',
      label: "Full Name",
      controller: TextEditingController(),
    );
    validation.addField(
      'user_name',
      label: "User name",
      controller: TextEditingController(),
    );
    validation.addField(
      'bank_account',
      label: "Bank account",
      controller: TextEditingController(),
    );
    validation.addField(
      'bank_name',
      label: "Bank name",
      controller: TextEditingController(),
    );
    validation.addField(
      'identity_id',
      label: "Identity ID",
      controller: TextEditingController(),
    );
    validation.addField(
      'gender',
      label: "Gender",
      controller: TextEditingController(),
    );
    validation.addField(
      'birthday',
      label: "Birthday",
      controller: TextEditingController(),
    );
    validation.addField(
      'phone_number',
      label: "Phone number",
      controller: TextEditingController(),
    );

    // avatar

    validation.addField(
      'type_name',
      label: "Type name",
      controller: TextEditingController(),
    );
    validation.addField(
      'country_name',
      label: "Country name",
      controller: TextEditingController(),
    );
    validation.addField(
      'position',
      label: "Position",
      controller: TextEditingController(),
    );
    validation.addField(
      'email',
      label: "Email",
      controller: TextEditingController(),
    );

    Future<UserProfile?> updateProfile({required UserProfile userProfile}) async {
      UserProfile editProfileRequest = userProfile.copyWith(
        fullName: validation.getController('fullName')?.text,
        userName: validation.getController('user_name')?.text,
        bankAccount: validation.getController('bank_account')?.text,
        bankName: validation.getController('bank_name')?.text,
        identityId: validation.getController('identity_id')?.text,
        gender: validation.getController('gender')?.text,
        birthday: validation.getController('birthday')?.text,
        phoneNumber: validation.getController('phone_number')?.text,
        avatar: validation.getController('avatar')?.text,
        typeName: validation.getController('type_name')?.text,
        countryName: validation.getController('country_name')?.text,
        position: validation.getController('position')?.text,
        email: validation.getController('email')?.text,
      );
      return editProfileRequest;
    }
  }
}
