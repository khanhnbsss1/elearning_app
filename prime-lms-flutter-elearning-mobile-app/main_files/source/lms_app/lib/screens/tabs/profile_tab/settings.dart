import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/widgets/popup_confirm/confirm_popup_page.dart';
import 'package:lms_app/mixins/user_mixin.dart';
import 'package:lms_app/screens/pdf_screen.dart';
import '../../../components/change_password.dart';
import '../../../configs/features_config.dart';
import '../../../providers/app_settings_provider.dart';
import '../../../providers/user_data_provider.dart';
import '../../auth/delete_account.dart';
import '../../../components/languages.dart';
import '../../../services/app_service.dart';
import '../../../services/notification_service.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/logout_dialog.dart';
import '../../../utils/next_screen.dart';
import '../../course_details.dart/lessons.dart';

class AppSettings extends ConsumerWidget with UserMixin {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool notificationEnbaled = ref.watch(nProvider);
    final settings = ref.watch(appSettingsProvider);
    final user = ref.watch(userDataProvider);
    print(settings);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ).tr(),
        // ListTile(
        //   leading: Icon(notificationEnbaled ? LineIcons.bell : LineIcons.bellSlash),
        //   title: const Text('notifications').tr(),
        //   trailing: Switch.adaptive(
        //     value: notificationEnbaled,
        //     onChanged: (value) => NotificationService().handleSubscription(context, value, ref),
        //   ),
        // ),
        // const Divider(),
        // ListTile(
        //   leading: const Icon(Icons.dark_mode),
        //   title: const Text('dark-mode').tr(),
        //   trailing: Switch.adaptive(
        //     value: ref.watch(themeProvider).isDarkMode,
        //     onChanged: (value) => ref.read(themeProvider.notifier).changeTheme(value),
        //   ),
        // ),
        user != null ? Column(
          children: [
            const Divider(),
            ListTile(
              title: const Text('change-password').tr(),
              leading: const Icon(LineIcons.passport),
              trailing: const Icon(FeatherIcons.chevronRight),
              onTap: () => NextScreen.openBottomSheet(context, ChangePassword(userProfile: user,)),
            ),
          ],
        ) : const SizedBox(),
        Visibility(
          visible: isMultilanguageEnbled,
          child: Column(
            children: [
              const Divider(),
              ListTile(
                title: const Text('language').tr(),
                leading: const Icon(LineIcons.language),
                trailing: const Icon(FeatherIcons.chevronRight),
                onTap: () => NextScreen.openBottomSheet(context, const Languages()),
              ),
            ],
          ),
        ),
        const Divider(),
        ListTile(
          title: const Text('privacy-policy').tr(),
          leading: const Icon(LineIcons.lock),
          trailing: const Icon(FeatherIcons.chevronRight),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (builder) {
                      return PdfScreen(
                          link: "assets/files/Chính sách bảo mật YAX.pdf",
                          pdfType: PdfType.asset,
                          name: "privacy-policy".tr());
                    }));
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('contact-us').tr(),
          leading: const Icon(LineIcons.envelope),
          trailing: const Icon(FeatherIcons.chevronRight),
          onTap: () {
            
            ConfirmPopupPage(
              content: 'contact-us'.tr(),
              title: 'contact-us'.tr(),
              enableAcceptButton: false,
              enableCancelButton: false,
              contentWidget: Padding(
                padding:  EdgeInsets.only(top: Dimens.size16, right: Dimens.size16, left: Dimens.size16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Hotline: ${ IdentifierConst.hotline}", style: TextStyleConstant.textStyleBlack14w500,),
                          Gap(Dimens.size8),
                          Icon(Icons.phone_in_talk, color: Colors.green,size: Dimens.size30,)
                        ],
                      ),
                      onTap: () {
                        AppService().openPhoneSupport(IdentifierConst.hotline);
                      },
                    ),
                    Gap(Dimens.size16),
                    InkWell(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Email: ${ IdentifierConst.supportEmail}", style: TextStyleConstant.textStyleBlack14w400,),
                          Gap(Dimens.size8),
                          Icon(Icons.email, color: Colors.green,size: Dimens.size30,)
                        ],
                      ),
                      onTap: () {
                        AppService().openEmailSupport(IdentifierConst.supportEmail);
                      },
                    ),
                  ],
                ),
              ),
            ).show(context);
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('rate-app').tr(),
          leading: const Icon(LineIcons.star),
          trailing: const Icon(FeatherIcons.chevronRight),
          onTap: () => AppService().launchAppReview(context),
        ),
        Visibility(
          visible: user != null,
          child: Column(
            children: [
              const Divider(),
              ListTile(
                title: const Text('account-control').tr(),
                leading: const Icon(LineIcons.userCog),
                trailing: const Icon(FeatherIcons.chevronRight),
                onTap: () => NextScreen.iOS(context, const DeleteAccount()),
              ),
              const Divider(),
              ListTile(
                title: const Text('logout').tr(),
                leading: const Icon(FeatherIcons.logOut),
                trailing: const Icon(FeatherIcons.chevronRight),
                onTap: () => openLogoutDialog(context, () {
                  handleLogout(context, ref: ref);
                }),
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 50, bottom: 20),
        //   child: const Text(
        //     'social',
        //     style: TextStyle(fontWeight: FontWeight.bold),
        //   ).tr(),
        // ),
        // Visibility(
        //   visible: true,
        //   child: Column(
        //     children: [
        //       ListTile(
        //         title: const Text('facebook').tr(),
        //         leading: const Icon(LineIcons.facebook),
        //         trailing: const Icon(FeatherIcons.chevronRight),
        //         onTap: () => AppService().openLink(settings!.social!.fb!),
        //       ),
        //       const Divider(),
        //     ],
        //   ),
        // ),
        // Visibility(
        //   visible: true,
        //   child: Column(
        //     children: [
        //       ListTile(
        //         title: const Text('youtube').tr(),
        //         leading: const Icon(LineIcons.youtube),
        //         trailing: const Icon(FeatherIcons.chevronRight),
        //         onTap: () => AppService().openLink(settings!.social!.youtube!),
        //       ),
        //       const Divider(),
        //     ],
        //   ),
        // ),
        // Visibility(
        //   visible: true,
        //   child: Column(
        //     children: [
        //       ListTile(
        //         title: const Text('twitter').tr(),
        //         leading: const Icon(FeatherIcons.twitter),
        //         trailing: const Icon(FeatherIcons.chevronRight),
        //         onTap: () => AppService().openLink(settings!.social!.twitter!),
        //       ),
        //       const Divider(),
        //     ],
        //   ),
        // ),
        // Visibility(
        //   visible: true,
        //   child: ListTile(
        //     title: const Text('instagram').tr(),
        //     leading: const Icon(FeatherIcons.instagram),
        //     trailing: const Icon(FeatherIcons.chevronRight),
        //     onTap: () => AppService().openLink(settings!.social!.instagram!),
        //   ),
        // ),
      ],
    );
  }
}
