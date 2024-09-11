import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/resizer/reponsive.dart';
import 'package:webkit/base/widgets/static_view/static_view.dart';
import 'package:webkit/controller/auth/login_controller.dart';
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/images.dart';
import 'package:webkit/views/auth/forgot_password.dart';
import 'package:webkit/views/auth/register.dart';
import 'package:webkit/views/layouts/auth_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  void show(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return this;
        });
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late LoginController loginController;

  @override
  void initState() {
    super.initState();
    loginController = LoginController();
    loginController.initUser();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      //key: UniqueKey(),
      child: GetBuilder<LoginController>(
        //key: UniqueKey(),
        init: loginController,
        builder: (controller) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.size16),
                color: Colors.white,
              ),
              child: Padding(
                padding: MySpacing.all(16),
                child: Stack(children: [
                  MyFlex(
                    contentPadding: false,
                    children: [
                      MyFlexItem(
                        sizes: "lg-6",
                        child: MyResponsive(
                          builder: (_, __, type) {
                            return type == MyScreenMediaType.xxl
                                ? Image.asset(
                                    Images.login[3],
                                    fit: BoxFit.cover,
                                    height: 500,
                                  )
                                : type == MyScreenMediaType.xl
                                    ? Image.asset(
                                        Images.login[3],
                                        fit: BoxFit.cover,
                                        height: 500,
                                      )
                                    : type == MyScreenMediaType.lg
                                        ? Image.asset(
                                            Images.login[3],
                                            fit: BoxFit.cover,
                                            height: 500,
                                          )
                                        : const SizedBox();
                          },
                        ),
                      ),
                      MyFlexItem(
                        sizes: "lg-6",
                        child: Padding(
                          padding: MySpacing.y(28),
                          child: Form(
                            key: loginController.basicValidator.formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: MyText.titleLarge(
                                    "${L10nX.getStr.welcome_str} ${L10nX.getStr.app_name}",
                                    fontWeight: 600,
                                    textAlign: TextAlign.center,
                                    fontSize: 24,
                                  ),
                                ),
                                Center(
                                  child: MyText.bodyMedium(
                                    L10nX.getStr.login_your_account,
                                    fontSize: 16,
                                  ),
                                ),
                                MySpacing.height(40),
                                MyText.bodyMedium(L10nX.getStr.your_email),
                                MySpacing.height(8),
                                TextFormField(
                                  validator: controller.basicValidator
                                      .getValidation('email'),
                                  controller: controller.basicValidator
                                      .getController('email'),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      labelText: L10nX
                                          .getStr.type_email_or_phone_number,
                                      labelStyle:
                                          MyTextStyle.bodySmall(xMuted: true),
                                      border: outlineInputBorder,
                                      prefixIcon: const Icon(
                                        LucideIcons.mail,
                                        size: 20,
                                      ),
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never),
                                ),
                                MySpacing.height(16),
                                MyText.labelMedium(
                                  L10nX.getStr.password,
                                ),
                                MySpacing.height(8),
                                TextFormField(
                                  validator: controller.basicValidator
                                      .getValidation('password'),
                                  controller: controller.basicValidator
                                      .getController('password'),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: !controller.showPassword,
                                  onFieldSubmitted: (value) {
                                    print("object");
                                    controller.onLogin();
                                  },
                                  decoration: InputDecoration(
                                      labelText: L10nX.getStr.password,
                                      labelStyle:
                                          MyTextStyle.bodySmall(xMuted: true),
                                      border: outlineInputBorder,
                                      prefixIcon: const Icon(
                                        LucideIcons.lock,
                                        size: 20,
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: controller.onChangeShowPassword,
                                        child: Icon(
                                          controller.showPassword
                                              ? LucideIcons.eye
                                              : LucideIcons.eyeOff,
                                          size: 20,
                                        ),
                                      ),
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () => controller.onChangeCheckBox(
                                          !controller.isChecked),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            onChanged:
                                                controller.onChangeCheckBox,
                                            value: controller.isChecked,
                                            activeColor:
                                                theme.colorScheme.primary,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            visualDensity: getCompactDensity,
                                          ),
                                          MySpacing.width(16),
                                          MyText.bodyMedium(
                                              L10nX.getStr.remember_me),
                                        ],
                                      ),
                                    ),
                                    MyButton.text(
                                      onTap: () {
                                        Navigator.pop(context);
                                        ForgotPassword().show(context);
                                      },
                                      elevation: 0,
                                      padding: MySpacing.xy(8, 0),
                                      splashColor: contentTheme.secondary
                                          .withOpacity(0.1),
                                      child: MyText.labelSmall(
                                        L10nX.getStr.forgot_password
                                            .capitalizeWords,
                                        color: contentTheme.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                                MySpacing.height(40),
                                Center(
                                  child: MyButton.rounded(
                                    onTap: controller.onLogin,
                                    elevation: 0,
                                    padding: MySpacing.xy(20, 16),
                                    backgroundColor: contentTheme.primary,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        controller.loading
                                            ? SizedBox(
                                                height: 14,
                                                width: 14,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: theme
                                                      .colorScheme.onPrimary,
                                                  strokeWidth: 1.2,
                                                ),
                                              )
                                            : Container(),
                                        if (controller.loading)
                                          MySpacing.width(16),
                                        MyText.bodySmall(
                                          L10nX.getStr.login,
                                          color: contentTheme.onPrimary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Center(
                                  child: MyButton.text(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      Register().show(context);
                                    },
                                    elevation: 0,
                                    padding: MySpacing.x(16),
                                    splashColor:
                                        contentTheme.secondary.withOpacity(0.1),
                                    child: MyText.labelMedium(
                                      L10nX.getStr.i_haven_t_account,
                                      color: contentTheme.secondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.close),
                    ),
                  )
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoginPage1 extends StatefulWidget {
  const LoginPage1({super.key});

  void show(BuildContext context) {
    showDialog(
        barrierDismissible: true, context: context, builder: (context) => this);
  }

  @override
  State<LoginPage1> createState() => _LoginState();
}

class _LoginState extends State<LoginPage1> {
  var emailCtlr = TextEditingController();
  var passwordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnCtlr =
      RoundedLoadingButtonController();
  bool _obsecureText = true;
  IconData _lockIcon = CupertinoIcons.eye_fill;

  _onChangeVisiblity() {
    if (_obsecureText == true) {
      setState(() {
        _obsecureText = false;
        _lockIcon = CupertinoIcons.eye;
      });
    } else {
      setState(() {
        _obsecureText = true;
        _lockIcon = CupertinoIcons.eye_fill;
      });
    }
  }

  void _handleLogin() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      _btnCtlr.start();
      // UserCredential? userCredential = await AuthService().loginWithEmailPassword(emailCtlr.text, passwordCtrl.text);
      // LoginRequest loginRequest
      //BlocProvider.of<LoginBloc>(context).add(LoginSubmittedEvent(loginRequest: loginRequest));
/*      if (userCredential?.user != null) {
        debugPrint('Login Success');
      } else {
        _btnCtlr.reset();
        if (!mounted) return;
      }*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.indigo.withOpacity(0.1),
        child: Row(
          children: [
            Visibility(
              visible: Responsive.isDesktop(context) ||
                  Responsive.isDesktopLarge(context),
              child: Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: ImageManager().getSvgImage(
                  ImageManager.ic_svgLoginImageString,
                  height: 400,
                  width: 400,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              // fit: FlexFit.tight,
              child: Form(
                key: formKey,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: _getHorizontalPadding(),
                      vertical: 30.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StaticView.buildLogo(),
                        Text(
                          'Sign In to the Admin Panel',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.blueGrey),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.grey.shade100,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailCtlr,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () => emailCtlr.clear(),
                                    icon: const Icon(Icons.clear),
                                  ),
                                  hintText: 'Email Address',
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(15),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Password',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.grey.shade100,
                              child: TextFormField(
                                controller: passwordCtrl,
                                obscureText: _obsecureText,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    suffixIcon: Wrap(
                                      children: [
                                        IconButton(
                                            onPressed: _onChangeVisiblity,
                                            icon: Icon(_lockIcon)),
                                        IconButton(
                                            onPressed: () =>
                                                passwordCtrl.clear(),
                                            icon: const Icon(Icons.clear)),
                                      ],
                                    ),
                                    hintText: 'Your Password',
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(15)),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            RoundedLoadingButton(
                              onPressed: _handleLogin,
                              controller: _btnCtlr,
                              color: Theme.of(context).primaryColor,
                              width: MediaQuery.of(context).size.width,
                              borderRadius: 0,
                              height: 55,
                              animateOnTap: false,
                              elevation: 0,
                              child: Text(
                                'Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getHorizontalPadding() {
    if (Responsive.isDesktopLarge(context)) {
      return 120;
    } else if (Responsive.isDesktop(context)) {
      return 80;
    } else if (Responsive.isTablet(context)) {
      return 100;
    } else {
      return 30;
    }
  }
}
