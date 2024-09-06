import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lms_app/components/privacy_info.dart';
import 'package:lms_app/controller_elearning/auth/register_controller.dart';
import 'package:lms_app/models/user_model.dart';
import 'package:lms_app/screens/auth/login.dart';
import 'package:lms_app/screens/splash.dart';
import 'package:lms_app/services/auth_service.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../base/widgets/toast_common/toast_utils.dart';
import '../../components/app_logo.dart';
import '../../providers/user_data_provider.dart';
import '../home/home_view.dart';
import 'social_logins.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key, this.popUpScreen});

  final bool? popUpScreen;

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  late RegisterController registerController;
  final _btnController = RoundedLoadingButtonController();

  bool offsecureText = true;
  IconData lockIcon = LineIcons.lock;

  @override
  void initState() {
    super.initState();
    registerController = RegisterController();
    registerController.onInit();
  }

  // UserModel _userModel(UserCredential userCredential) {
  //   final UserModel user = UserModel(
  //     id: userCredential.user!.uid,
  //     email: userCredential.user!.email ?? emailCtlr.text,
  //     name: userCredential.user!.displayName ?? nameCtlr.text,
  //     createdAt: DateTime.now().toUtc(),
  //     imageUrl: userCredential.user?.photoURL,
  //     platform: Platform.isAndroid ? 'Android' : 'iOS',
  //   );
  //   return user;
  // }

  // Future _handleSignUpWithUsernamePassword() async {
  //   if (formKey.currentState!.validate()) {
  //     formKey.currentState!.save();
  //     _btnController.start();
  //     final UserCredential? userCredential =
  //         await AuthService().signUpWithEmailPassword(context, emailCtlr.text.trim(), passwordCtrl.text.trim()).onError((error, stackTrace) {
  //       _btnController.reset();
  //       return null;
  //     });
  //     if (userCredential != null && userCredential.user != null) {
  //       // await FirebaseService().saveUserData(_userModel(userCredential));
  //       await FirebaseService().updateUserStats();
  //       _btnController.success();
  //       await AuthService().sendEmailVerification();
  //       afterSignIn();
  //     } else {
  //       _btnController.reset();
  //     }
  //   }
  // }

  Future _handleSignUpWithUsernamePassword() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      _btnController.start();
      bool register = await registerController.onRegister();
      if (!register) {
        afterSignUp();
      } else {
        ToastUtils.showToastError("Register failed");
        _btnController.stop();
      }
    }
  }

  void _onlockPressed() {
    if (offsecureText == true) {
      setState(() {
        offsecureText = false;
        lockIcon = LineIcons.lockOpen;
      });
    } else {
      setState(() {
        offsecureText = true;
        lockIcon = LineIcons.lock;
      });
    }
  }

  void afterSignUp() async {
    Navigator.of(context).pop();
    await ref.read(userDataProvider.notifier).getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 25, right: 25,top: 30),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'create-account',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
                ).tr(),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const AppLogo(size: 100,),
                ),
                // SocialLogins(
                //   afterSignIn: afterSignIn,
                // ),
                // Container(
                //   alignment: Alignment.center,
                //   padding: const EdgeInsets.symmetric(vertical: 20),
                //   child: const Text(
                //     '------ OR ------',
                //     style: TextStyle(color: Colors.blueGrey),
                //   ),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          hintText: 'enter-name'.tr(),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                          label: Text.rich(
                            TextSpan(
                              text: 'name'.tr(),
                              children: const <TextSpan>[
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.clear,
                              size: 20,
                            ),
                            onPressed: () => registerController.basicValidator.getController('first_name')?.clear(),
                          )),
                      controller: registerController.basicValidator.getController('first_name'),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) return 'Name is required';
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          hintText: 'enter-phone'.tr(),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                          label: Text.rich(
                            TextSpan(
                              text: 'phone-number'.tr(),
                              children: const <TextSpan>[
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.clear,
                              size: 20,
                            ),
                            onPressed: () => registerController.basicValidator.getController('user_name')?.clear(),
                          )),
                      controller: registerController.basicValidator.getController('phone'),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) return 'Name is required';
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          hintText: 'enter-email'.tr(),
                          label: Text.rich(
                            TextSpan(
                              text: 'email'.tr(),
                              children: const <TextSpan>[
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.clear,
                              size: 20,
                            ),
                            onPressed: () => registerController.basicValidator.getController('email')?.clear(),
                          )),
                      controller: registerController.basicValidator.getController('email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) return 'Email is required';
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          hintText: 'enter-password'.tr(),
                          label: Text.rich(
                            TextSpan(
                              text: 'password'.tr(),
                              children: const <TextSpan>[
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                          suffixIcon: IconButton(
                            padding: const EdgeInsets.all(0),
                            style: IconButton.styleFrom(padding: const EdgeInsets.all(0)),
                            icon: Icon(
                              lockIcon,
                              size: 20,
                            ),
                            onPressed: () => _onlockPressed(),
                          )),
                      controller: registerController.basicValidator.getController('password'),
                      obscureText: offsecureText,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) return 'Password is required';
                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
                    RoundedLoadingButton(
                      animateOnTap: false,
                      controller: _btnController,
                      onPressed: () => _handleSignUpWithUsernamePassword(),
                      width: MediaQuery.of(context).size.width * 1.0,
                      color: Theme.of(context).primaryColor,
                      elevation: 0,
                      child: Text(
                        'create-account',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
                      ).tr(),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 15),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "already-have-account",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                          ).tr(),
                          TextButton(
                              child: Text(
                                'login',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 15),
                              ).tr(),
                              onPressed: () => Navigator.of(context).pop()),
                        ],
                      ),
                    ),
                    const PrivacyInfo(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
