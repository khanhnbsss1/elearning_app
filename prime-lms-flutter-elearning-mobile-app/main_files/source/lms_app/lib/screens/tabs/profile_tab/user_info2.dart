import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/base/author/user_helper.dart';
import 'package:lms_app/screens/tabs/profile_tab/guest_user.dart';
import '../../../components/user_avatar.dart';
import '../../../models/user/UserProfile.dart';
import '../../../services/apis/user/get_user_detail_api.dart';
import '../../../utils/snackbars.dart';
import '../../edit_profile.dart';

class UserInfo2 extends StatefulWidget {
  const UserInfo2({
    super.key,
  });

  @override
  State<UserInfo2> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo2> {
  @override
  Widget build(BuildContext context) {
    UserProfile? user = UserManager().getUserProfile();
    if (user != null) {
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
                            setState(() {});
                          } else {
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
                imageUrl: user.avatar, radius: 50, iconSize: 25),
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
  }

  Future<UserProfile> getProfile() async {
    GetUserProfileInfoApi getUserProfileInfoApi = GetUserProfileInfoApi();
    UserProfile user = await getUserProfileInfoApi.call();
    return user;
  }
}
