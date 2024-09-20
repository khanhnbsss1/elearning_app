import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/screens/tabs/dictionary/search_word/search_word_view.dart';
import 'package:lms_app/screens/tabs/dictionary/word_screen.dart';
import 'package:lms_app/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:lms_app/services/apis/vocabulary/vocabulary_list/vocabulary_list_api.dart';
import 'package:lms_app/utils/loading_widget.dart';

import '../../../base/widgets/audio/audio_speaker.dart';
import '../../../services/api_service.dart';
import '../../../utils/next_screen.dart';

// final dictionaryProvider = FutureProvider.family
//     .autoDispose<List<VocabularyInfo>?, int>((ref, pageNumber) async {
//   List<VocabularyInfo> dictionaries =
//       await ApiService().getDictionary(pageNumber, "");
//   return dictionaries;
// });

final dictionaryTypeProvider = StateProvider<DictionaryType>((ref) => DictionaryType.noImage);


class Dictionary extends ConsumerStatefulWidget {
  const Dictionary({super.key});

  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends ConsumerState<Dictionary> {
  List<VocabularyInfo> _dictionaries = [];
  int _pageNumber = 0;
  bool lastPage = false;
  late ScrollController _controller;
  late bool isLoading;

  void initState() {
    super.initState();
    _controller = ScrollController(initialScrollOffset: 0.0);
    _controller.addListener(_scrollListener);
    isLoading = false;
    getWord();
  }

  @override
  void didUpdateWidget(Dictionary oldWidget) {
    super.didUpdateWidget(oldWidget);
    // ref.watch(dictionaryTypeProvider);
    // _dictionaries.clear();
    // _pageNumber = 0;
    // getWord();
  }

  Future<void> _loadMore() async {
    setState(() {
      _pageNumber++;
      getWord();
    });
  }

  _scrollListener() async {
    var isEnd = _controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange;
    if (isEnd) {
      if (!lastPage) _loadMore();
    }
  }

  Future<void> getWord() async {
    DictionaryType dictionaryType = ref.read(dictionaryTypeProvider);
    final List<VocabularyInfo> dictionaries =
        await ApiService().getDictionary(_pageNumber, "", dictionaryType);
    isLoading = true;
    if (_dictionaries != [] && dictionaries != []) {
      setState(() {
        _dictionaries = _dictionaries + dictionaries;
      });
    } else {
      lastPage = true;
      setState(() {
        dictionaries ?? [];
      });
    }
  }

  _onRefresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(dictionaryTypeProvider, (_, __) {
      _dictionaries.clear();
      _pageNumber = 0;
      getWord();
      isLoading = false;
    });
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 60,
        title: InkWell(
          onTap: () => NextScreen.iOS(context, const SearchWordScreen()),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey, width: 0.5),
              borderRadius: BorderRadius.circular(120),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'search-word',
                  style: Theme.of(context).textTheme.bodyLarge,
                ).tr(),
                const Icon(FeatherIcons.search, size: 20),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: ref.watch(dictionaryTypeProvider) == DictionaryType.noImage,
                      onChanged: (value) {
                        if (value!) {
                          ref.read(dictionaryTypeProvider.notifier).state = DictionaryType.noImage;
                        }
                      },
                    ),
                    Text("dictionary1".tr()),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: ref.watch(dictionaryTypeProvider) == DictionaryType.Image,
                      onChanged: (value) {
                        if (value!) {
                          ref.read(dictionaryTypeProvider.notifier).state = DictionaryType.Image;
                        }
                      },
                    ),
                    Text("dictionary2".tr()),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: (isLoading) ? ListView.builder(
              controller: _controller,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 0, bottom: 20),
              itemCount: _dictionaries.length,
              itemBuilder: (context, index) {
                ref.watch(dictionaryTypeProvider);
                final VocabularyInfo word = _dictionaries[index];
                return ListTile(
                  onTap: () {
                    NextScreen.normal(context, WordScreen(word: word));
                  },
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
            ) : const LoadingIndicatorWidget(),
          ),
        ],
      ),
    );
  }
}
