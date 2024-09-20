import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/screens/tabs/profile_tab/settings.dart';
import 'package:lms_app/screens/tabs/profile_tab/user_info2.dart';
import '../../../models/user/UserProfile.dart';
import '../../../providers/user_data_provider.dart';
import '../../../services/apis/user/get_user_detail_api.dart';
import '../../../theme/theme_provider.dart';
import 'guest_user.dart';
import 'user_info.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: (isDarkMode != true) ? Colors.white : Colors.black.withOpacity(0.1),
          title: const Text('profile').tr(),
          pinned: true,
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: (isDarkMode != true) ? Colors.white : Colors.black.withOpacity(0.1),
            child: const SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // user == null ? const GuestUser() :
                  Center(
                    child: SizedBox(
                      height: 100,
                        child: UserInfo2()),
                  ),
                  AppSettings(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
