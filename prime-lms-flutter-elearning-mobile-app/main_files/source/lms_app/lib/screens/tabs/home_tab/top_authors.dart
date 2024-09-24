import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/components/author_card.dart';
import 'package:lms_app/components/loading_tile.dart';
import 'package:lms_app/helper/localizations/language_helper.dart';
import 'package:lms_app/models/user_model.dart';
import 'package:lms_app/screens/all_authors.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/utils/next_screen.dart';

import '../../../models/user/UserProfile.dart';
import '../../../services/apis/teacher_list/models/landing_page_teacher_list_model.dart';
import '../../../services/apis/teacher_list/models/teacher_model.dart';
import '../../../theme/theme_provider.dart';

final topAuthorsProvider =
    FutureProvider.autoDispose<List<TeacherDetail>>((ref) async {
  final List<TeacherDetail> teacherList = await ApiService().getTopAuthors1();
  return teacherList;
});

class TopAuthors extends ConsumerWidget {
  const TopAuthors({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authors = ref.watch(topAuthorsProvider);
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    return authors.when(
        skipLoadingOnRefresh: false,
        data: (data) {
          return (data.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                              'instructors'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold),
                            )),
                            TextButton(
                              onPressed: () => NextScreen.normal(
                                  context, AllAuthors()),
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(0)),
                              child: Text(
                                'view-all',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    // color: (isDarkMode != true) ? Colors.black : Colors.white
                                    color: Colors.black,
                                ),
                              ).tr(),
                            )
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: data.take(5).map((user) {
                            return AuthorCard(teacherDetail: user, isDarkMode: isDarkMode);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox();
        },
        error: (e, x) => Text('error: $e, $x'),
        loading: () => const LoadingTile(height: 300));
  }
}
