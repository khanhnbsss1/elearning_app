import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lms_app/base/author/user_helper.dart';
import 'package:lms_app/base/widgets/toast_common/toast_utils.dart';
import 'package:lms_app/components/app_logo.dart';
import 'package:lms_app/components/privacy_info.dart';
// import 'package:lms_app/models/user/UserProfile.dart';
import 'package:lms_app/screens/auth/reset_password.dart';
import 'package:lms_app/screens/auth/sign_up.dart';
import 'package:lms_app/screens/home/home_view.dart';
import 'package:lms_app/screens/splash.dart';
import 'package:lms_app/services/auth_service.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../controller_elearning/auth/login_controller.dart';
import '../../l10n/l10n_extention.dart';
import '../../models_elearning/user/UserProfile.dart';
import '../../providers/user_data_provider.dart';
import 'social_logins.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key, this.popUpScreen});

  final bool? popUpScreen;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  // var emailCtlr = TextEditingController();
  // var passwordCtrl = TextEditingController();
  final _btnController = RoundedLoadingButtonController();
  late LoginController loginController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginController = LoginController();
    loginController.initUser();
  }

  bool offsecureText = true;
  IconData lockIcon = LineIcons.lock;

  // Future _handleLoginWithUsernamePassword() async {
  //   if (formKey.currentState!.validate()) {
  //     formKey.currentState!.save();
  //     _btnController.start();
  //     final UserCredential? user = await AuthService().loginWithEmailPassword(context, "0348074377", "Ll@123456");
  //     if (user != null) {
  //       _btnController.success();
  //       afterSignIn();
  //     } else {
  //       _btnController.reset();
  //     }
  //   }
  // }

  Future _handleLoginWithUsernamePassword() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      _btnController.start();
      bool login = await loginController.onLogin();
      if (!login) {
        _btnController.success();
        afterSignIn();
      } else {
        ToastUtils.showToastError("Your username or password is wrong");
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

  void afterSignIn() async {
      NextScreen.closeOthersAnimation(context, const HomeView());
      await ref.read(userDataProvider.notifier).getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: widget.popUpScreen??true,
      appBar: AppBar(
        leading: (widget.popUpScreen == true) ? IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ) : const SizedBox(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 50),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'login',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
              ).tr(),
              const SizedBox(
                height: 5,
              ),
              Text(
                'login-to-access-features',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ).tr(),
              // SocialLogins(
              //   afterSignIn: afterSignIn,
              // ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const AppLogo(size: 100,),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        hintText: 'enter-email'.tr(),
                        label: const Text('email').tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.clear,
                            size: 20,
                          ),
                          onPressed: () => loginController.basicValidator.getController('email')?.clear(),
                        )),
                    controller: loginController.basicValidator.getController('email'),
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        label: const Text('password').tr(),
                        suffixIcon: IconButton(
                          padding: const EdgeInsets.all(0),
                          style: IconButton.styleFrom(padding: const EdgeInsets.all(0)),
                          icon: Icon(
                            lockIcon,
                            size: 20,
                          ),
                          onPressed: () => _onlockPressed(),
                        )),
                    controller: loginController.basicValidator.getController('password'),
                    obscureText: offsecureText,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) return 'Password is required';
                      return null;
                    },
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: const Text(
                        'forgot-password',
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent),
                      ).tr(),
                      onPressed: () => NextScreen.iOS(context, const ResetPassword()),
                    ),
                  ),
                  RoundedLoadingButton(
                    animateOnTap: false,
                    controller: _btnController,
                    onPressed: () => _handleLoginWithUsernamePassword(),
                    width: MediaQuery.of(context).size.width * 1.0,
                    color: Theme.of(context).primaryColor,
                    elevation: 0,
                    child: Text(
                      'login',
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
                          "no-account",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                        ).tr(),
                        TextButton(
                            child: Text(
                              'create-account',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 15),
                            ).tr(),
                            onPressed: () => NextScreen.replace(context, const SignUpScreen())),
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
    );
  }
}
