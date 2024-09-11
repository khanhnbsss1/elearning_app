import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/components/loading_list_tile.dart';
import 'package:lms_app/configs/app_assets.dart';
import 'package:lms_app/screens/tabs/dictionary/search_word/search_word_view.dart';
import 'package:lms_app/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:lms_app/utils/empty_animation.dart';
import '../../../../base/widgets/audio/audio_speaker.dart';

class SearchedWords extends ConsumerWidget {
  const SearchedWords({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesProvider = ref.watch(searchedWordProvider);
    return coursesProvider.when(
      loading: () => const LoadingListTile(height: 160),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
      data: (dictionary) {
        if (dictionary!.isEmpty) return EmptyAnimation(animationString: emptyAnimation, title: 'no-word'.tr());
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: dictionary.length,
          separatorBuilder: (context, index) => const Divider(height: 10),
          itemBuilder: (context, index) {
            final VocabularyInfo word = dictionary[index];
            return ListTile(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              horizontalTitleGap: 10,
              title: Text(
                word.simplified!,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              subtitle: (word.translationVn != "")
                  ? Text(word.translationVn ?? "-")
                  : const Text("-"),
              trailing: AudioSpeaker(
                url: word.audioLink ?? "",
                enableProccessBar: false,
              ),
            );
          },
        );
      },
    );
  }
}
