import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lms_app/components/app_logo.dart';
import 'package:lms_app/components/privacy_info.dart';

import 'package:lms_app/screens/auth/sign_up.dart';
import 'package:lms_app/screens/home/home_view.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../base/constant.dart';
import '../../components/languages.dart';
import '../../configs/features_config.dart';
import '../../controller_elearning/auth/login_controller.dart';
import '../../providers/user_data_provider.dart';
import '../../services/app_service.dart';
import '../home/home_bottom_bar.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';


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

  Future _handleLoginWithUsernamePassword() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      _btnController.start();
      bool login = await loginController.onLogin();
      if (login) {
        _btnController.success();
        afterSignIn();
      } else {
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
    ref.invalidate(userDataProvider);
    ref.invalidate(homeTabControllerProvider);
    ref.invalidate(navBarIndexProvider);
    ref.invalidate(homeShowTelProvider);
    await ref.read(userDataProvider.notifier).getData();
    NextScreen.closeOthersAnimation(context, const HomeView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: widget.popUpScreen ?? true,
      body: Center(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 50),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'login',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
                    ).tr(),
                    const Spacer(),
                    Visibility(
                      visible: isMultilanguageEnbled,
                      child: IconButton(
                        padding: const EdgeInsets.only(right: 10),
                        icon: const Icon(LineIcons.language),
                        onPressed: () => NextScreen.openBottomSheet(
                            context, const Languages()),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'login-to-access-features',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary),
                ).tr(),
                // SocialLogins(
                //   afterSignIn: afterSignIn,
                // ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const AppLogo(
                    size: 100,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          hintText: 'enter-email-or-phone'.tr(),
                          label: const Text('email-or-phone').tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.clear,
                              size: 20,
                            ),
                            onPressed: () => loginController.basicValidator
                                .getController('email')
                                ?.clear(),
                          )),
                      controller:
                          loginController.basicValidator.getController('email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) return 'Email is required';
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          hintText: 'enter-password'.tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          label: const Text('password').tr(),
                          suffixIcon: IconButton(
                            padding: const EdgeInsets.all(0),
                            style: IconButton.styleFrom(
                                padding: const EdgeInsets.all(0)),
                            icon: Icon(
                              lockIcon,
                              size: 20,
                            ),
                            onPressed: () => _onlockPressed(),
                          )),
                      controller: loginController.basicValidator
                          .getController('password'),
                      obscureText: offsecureText,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) return 'Password is required';
                        return null;
                      },
                    ),
                    // Container(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     child: const Text(
                    //       'forgot-password',
                    //       style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent),
                    //     ).tr(),
                    //     onPressed: () => NextScreen.openBottomSheet(context, const ResetPassword()),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          activeColor: Theme.of(context).primaryColor,
                          value: loginController.rememberMe,
                          onChanged: (value) {
                            setState(() {
                              loginController.onChangeRememberMe();
                            });
                          },
                        ),
                        const Text('remember-me').tr(),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ).tr(),
                          TextButton(
                              child: Text(
                                'create-account',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                              ).tr(),
                              onPressed: () => NextScreen.openBottomSheet(
                                  context, const SignUpScreen())),
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
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        type: ExpandableFabType.side,
        childrenAnimation: ExpandableFabAnimation.rotate,
        distance: 70,
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Icons.help_outline),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          shape: const CircleBorder(),
          angle: 3.14 * 2,
        ),
        closeButtonBuilder: FloatingActionButtonBuilder(
          size: 45,
          builder: (BuildContext context, void Function()? onPressed,
              Animation<double> progress) {
            return Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(30)
              ),
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.close,
                  size: 25,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            );
          },
        ),
        children: [
          FloatingActionButton.small(
            backgroundColor: Theme.of(context).primaryColor,
            shape: const CircleBorder(),
            heroTag: null,
            onPressed: () => AppService().openPhoneSupport(IdentifierConst.hotline),
            child: const Icon(Icons.phone_in_talk_outlined, color: Colors.white,),
          ),
          FloatingActionButton.small(
            backgroundColor: Theme.of(context).primaryColor,
            shape: const CircleBorder(),
            heroTag: null,
            onPressed: () => AppService().openEmailSupport(IdentifierConst.supportEmail),
            child: const Icon(Icons.email, color: Colors.white,),
          ),
        ],
      ),
    );
  }
}
