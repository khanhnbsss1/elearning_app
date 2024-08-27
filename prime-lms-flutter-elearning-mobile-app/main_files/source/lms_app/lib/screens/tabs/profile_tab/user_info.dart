import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/configs/app_assets.dart';
import 'package:lms_app/iAP/iap_config.dart';
import 'package:lms_app/iAP/iap_screen.dart';
import 'package:lms_app/models/app_settings_model.dart';
import 'package:lms_app/providers/app_settings_provider.dart';
import 'package:lms_app/screens/tabs/profile_tab/guest_user.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../components/user_avatar.dart';
import '../../../mixins/user_mixin.dart';
import '../../../models/user_model.dart';
import '../../../models/user/UserProfile.dart';
import '../../../services/apis/user/get_user_detail_api.dart';
import '../../edit_profile.dart';
import '../../../utils/next_screen.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({
    super.key,
  });

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    print('rebuilt UserInfo');
    return FutureBuilder(
        future: getProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserProfile user = snapshot.data!;
            return Column(
              children: [
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfile(
                                  user: user,
                                  onUpdate: (value) async {
                                      if (value) {
                                        setState(() {

                                        });
                                      }
                                  },
                                )));
                  },
                  title: Text(
                    user.fullName ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.email ?? ""),
                    ],
                  ),
                  leading: UserAvatar(
                      imageUrl: user.imageUrl, radius: 50, iconSize: 25),
                  trailing: const Icon(
                    FeatherIcons.edit3,
                    size: 20,
                  ),
                ),
                // Consumer(
                //   builder: (context, ref, child) {
                //     final settings = ref.watch(appSettingsProvider);
                //     if (IAPConfig.iAPEnabled &&
                //         settings?.license == LicenseType.extended) {
                //       return InkWell(
                //         child: user.subscription == null
                //             ? _noSubscriptionContainer(context)
                //             : _subscriptionContainer(context),
                //         onTap: () =>
                //             NextScreen.openBottomSheet(
                //                 context, const IAPScreen(),
                //                 isDismissable: false),
                //       );
                //     } else {
                //       return const SizedBox.shrink();
                //     }
                //   },
                // )
              ],
            );
          } else {
            return const GuestUser();
          }
        });
  }

  Future<UserProfile> getProfile() async {
    GetUserProfileInfoApi getUserProfileInfoApi = GetUserProfileInfoApi();
    UserProfile user = await getUserProfileInfoApi.call();
    return user;
  }
}
