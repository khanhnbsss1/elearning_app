import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/screens/tabs/dictionary/search_word/recent_searches_word.dart';
import 'package:lms_app/screens/tabs/dictionary/search_word/search_word_bar.dart';
import 'package:lms_app/screens/tabs/dictionary/search_word/searched_words.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:lms_app/utils/empty_icon.dart';

final searchTextWordCtlrProvider = Provider.autoDispose((ref) => TextEditingController());
final searchWordStartedProvider = StateProvider.autoDispose<bool>((ref) => false);
final recentSearchWordProvider = StateProvider<List<String>>((ref) => []);

final searchedWordProvider = FutureProvider.autoDispose<List<VocabularyInfo>?>((ref) async {
  final value = ref.watch(searchTextWordCtlrProvider).text;
  final words = await ApiService().getDictionary(0, value);
  return words;
});

class SearchWordScreen extends ConsumerWidget {
  const SearchWordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchFieldCtrl = ref.watch(searchTextWordCtlrProvider);
    final bool searchStarted = ref.watch(searchWordStartedProvider);
    final recentSearchList = ref.watch(recentSearchWordProvider);

    Widget buildView() {
      if (searchStarted) {
        return const SearchedWords();
      } else {
        if (recentSearchList.isNotEmpty) {
          return const RecentSearchWords();
        } else {
          return EmptyPageWithIcon(icon: FeatherIcons.search, title: 'search-word'.tr());
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: SearchWordAppBar(searchTextCtlr: searchFieldCtrl),
        leading: IconButton(
          icon: const Icon(FeatherIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const Divider(height: 5),
          Expanded(child: buildView()),
        ],
      ),
    );
  }
}
