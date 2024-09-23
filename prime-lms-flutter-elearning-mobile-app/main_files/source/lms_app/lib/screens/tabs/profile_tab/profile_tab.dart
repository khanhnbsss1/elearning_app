import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/screens/tabs/profile_tab/settings.dart';
import 'package:lms_app/screens/tabs/profile_tab/user_info2.dart';
import '../../../theme/theme_provider.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('profile', style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),).tr(),
          pinned: true,
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        const SliverToBoxAdapter(
          child: SingleChildScrollView(
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
        )
      ],
    );
  }
}
