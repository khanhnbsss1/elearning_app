import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/localizations/bloc/main.exports.dart';
import 'package:webkit/helpers/localizations/language_helper.dart';
import 'package:webkit/helpers/theme/app_notifier.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/theme/theme_customizer.dart';
import 'package:webkit/helpers/utils/my_shadow.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_card.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_dashed_divider.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/images.dart';
import 'package:webkit/widgets/custom_pop_menu.dart';

import '../../helpers/services/navigation_service.dart';

class TopBar extends StatefulWidget {
  Widget? title;
  bool? showBackButton;
  TopBar({
    super.key, // this.onMenuIconTap,
    this.title,
    this.showBackButton
  });

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar>
    with SingleTickerProviderStateMixin, UIMixin {
  Function? languageHideFn;
  LANGUAGE_INDEX mLanguageIndex = LANGUAGE_INDEX.VIETNAMESE;

  @override
  Widget build(BuildContext context) {
    UserProfile? userProfile =  UserManager().getUserProfile();
    return MyCard(
      shadow: MyShadow(position: MyShadowPosition.bottomRight, elevation: 0.5),
      height: 60,
      borderRadiusAll: 0,
      padding: MySpacing.x(24),
      color: topBarTheme.background.withAlpha(246),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ( widget.showBackButton??false)? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BackButtonCustom(buildContext: context),
                    Gap(Dimens.size16,),
                  ],
                ): SizedBox(),

                widget.title??SizedBox(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MySpacing.width(12),
                CustomPopupMenu(
                  backdrop: true,
                  hideFn: (_) => languageHideFn = _,
                  onChange: (_) {},
                  offsetX: -36,
                  menu: Padding(
                    padding: MySpacing.xy(8, 8),
                    child: Center(
                      child: ClipRRect(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        borderRadius: BorderRadius.circular(2),
                        child: Image.asset(
                          "assets/lang/${LanguageHelper().getCurrentLocale().languageCode??'vi'}.png",
                          width: 24,
                          height: 18,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  menuBuilder: (_) => buildLanguageSelector( context),
                ),
                MySpacing.width(10),
                CustomPopupMenu(
                  backdrop: false,
                  onChange: (_) {},
                  offsetX: -60,
                  offsetY: 8,
                  menu: Padding(
                    padding: MySpacing.xy(8, 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyContainer.rounded(
                            paddingAll: 0,
                            child:
                            (userProfile!=null && (userProfile.avatar??'').isNotEmpty)?
                            ImageManager().getImageByUrl(
                              userProfile.avatar??'',
                              height: 28,
                              width: 28,
                              boxFit: BoxFit.cover,
                              errorBuilder: Image.asset(
                                'assets/deshboard/profile.png',
                                height: 28,
                                width: 28,
                                fit: BoxFit.cover,
                              ),
                            ):
                            Image.asset(
                              'assets/deshboard/profile.png',
                              height: 28,
                              width: 28,
                              fit: BoxFit.cover,
                            )),
                        MySpacing.width(8),
                        // MyText.labelLarge('${snapshot.data?.fullName}')
                        MyText.labelLarge(userProfile?.fullName??'')
                      ],
                    ),
                  ),
                  menuBuilder: (context) {
                    return  buildAccountMenu();
                  },
                ),
              ],
            ),
          ]
      ),
    );
    
  }
  Widget buildLanguageSelector( BuildContext context) {
    List<Widget> childrenLanguage=[];
    for(LanguageInfo language in LanguageHelper().supportedLanguages)
      {
        childrenLanguage.add(MyButton.text(
          padding: MySpacing.xy(8, 4),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          splashColor: contentTheme.onBackground.withAlpha(20),
          onTap: () async {
            LanguageHelper().changeLanguage(language, context);
          },
          child: Row(
            children: [
              ClipRRect(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadius: BorderRadius.circular(2),
                  child: Image.asset(
                    "assets/lang/${language.languageCode}.png",
                    width: 18,
                    height: 14,
                    fit: BoxFit.cover,
                  )),
              MySpacing.width(8),
              MyText.labelMedium(language.language??"")
            ],
          ),
        ));
      }
    return MyContainer.bordered(
      padding: MySpacing.xy(8, 8),
      width: 125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: childrenLanguage,
      ),
    );
  }
  void changeLanguage(LanguageInfo language, BuildContext context) {
    Locale locale = LANGUAGE_MAPS[language.languageIndex]!;
    AppNotifier().changeLanguage(language, notify: false);
    BlocProvider.of<MainBloc>(NavigationService.globalContext!).add(MainChangeLanguageEvent(locale: locale));
  }
  Widget buildNotifications() {
    Widget buildNotification(String title, String description) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.labelLarge(title),
          MySpacing.height(4),
          MyText.bodySmall(description)
        ],
      );
    }

    return MyContainer.bordered(
      paddingAll: 0,
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.xy(16, 12),
            child: MyText.titleMedium("Notification", fontWeight: 600),
          ),
          MyDashedDivider(
              height: 1, color: theme.dividerColor, dashSpace: 4, dashWidth: 6),
          Padding(
            padding: MySpacing.xy(16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildNotification("Your order is received",
                    "Order #1232 is ready to deliver"),
                MySpacing.height(12),
                buildNotification("Account Security ",
                    "Your account password changed 1 hour ago"),
              ],
            ),
          ),
          MyDashedDivider(
              height: 1, color: theme.dividerColor, dashSpace: 4, dashWidth: 6),
          Padding(
            padding: MySpacing.xy(16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton.text(
                  onTap: () {},
                  splashColor: contentTheme.primary.withAlpha(28),
                  child: MyText.labelSmall(
                    "View All",
                    color: contentTheme.primary,
                  ),
                ),
                MyButton.text(
                  onTap: () {},
                  splashColor: contentTheme.danger.withAlpha(28),
                  child: MyText.labelSmall(
                    "Clear",
                    color: contentTheme.danger,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget buildAccountMenu() {
    return MyContainer.bordered(
      paddingAll: 0,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.xy(8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyButton(
                  onTap: () {
                    AppPages.routeName(Routes.userEdit);
                    setState(() {});
                  },
                  // onPressed: () =>
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  borderRadiusAll: AppStyle.buttonRadius.medium,
                  padding: MySpacing.xy(8, 4),
                  splashColor: theme.colorScheme.onSurface.withAlpha(20),
                  backgroundColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        FeatherIcons.user,
                        size: 14,
                        color: contentTheme.onBackground,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium(
                        L10nX.getStr.profile,
                        fontWeight: 600,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: MySpacing.xy(8, 8),
            child: MyButton(
              key: UniqueKey(),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onTap: () async {
                await AuthorManager().handleLogout();
                AppPages.routeName(Routes.landingPageRoute, isReplace: true);
              },
              borderRadiusAll: AppStyle.buttonRadius.medium,
              padding: MySpacing.xy(8, 4),
              splashColor: contentTheme.danger.withAlpha(28),
              backgroundColor: Colors.transparent,
              child: Row(
                children: [
                  Icon(
                    FeatherIcons.logOut,
                    size: 14,
                    color: contentTheme.danger,
                  ),
                  MySpacing.width(8),
                  MyText.labelMedium(
                    L10nX.getStr.sign_out_text,
                    fontWeight: 600,
                    color: contentTheme.danger,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
