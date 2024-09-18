import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/screens/tabs/dictionary/search_word/search_word_view.dart';
import 'package:lms_app/screens/tabs/dictionary/word_screen.dart';
import 'package:lms_app/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';

import '../../../base/widgets/audio/audio_speaker.dart';
import '../../../services/api_service.dart';
import '../../../utils/next_screen.dart';

final dictionaryProvider = FutureProvider.family
    .autoDispose<List<VocabularyInfo>?, int>((ref, pageNumber) async {
  List<VocabularyInfo> dictionaries =
      await ApiService().getDictionary(pageNumber,"");
  return dictionaries;
});

class Dictionary extends ConsumerStatefulWidget {
  const Dictionary({super.key});

  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends ConsumerState<Dictionary> {
  List<VocabularyInfo> _dictionaries = [];
  bool _hasData = false;
  bool _isLoading = true;
  int _pageNumber = 0;
  bool lastPage = false;
  late ScrollController _controller;

  void initState() {
    super.initState();
    _controller = ScrollController(initialScrollOffset: 0.0);
    _controller.addListener(_scrollListener);
    getWord();
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
    final List<VocabularyInfo> dictionaries = await ApiService().getDictionary(_pageNumber,"");
    if (_dictionaries != [] && dictionaries != []) {
      setState(() {
        _isLoading = false;
        _dictionaries = _dictionaries + dictionaries;
      });
    } else {
      lastPage = true;
      setState(() {
        _isLoading = false;
        dictionaries ?? [];
      });
    }
  }

  _onRefresh() async {
    _isLoading = true;
    _hasData = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: ListView.builder(
        controller: _controller,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 0, bottom: 20),
        itemCount: _dictionaries.length,
        itemBuilder: (context, index) {
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
      ),
    );
  }
}
