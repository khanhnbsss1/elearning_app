import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/base/widgets/audio/audio_speaker.dart';
import 'package:lms_app/screens/tabs/dictionary/search_word/search_word_view.dart';
import 'package:lms_app/services/apis/sentence/models/sentence_info.dart';
import '../../../services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import '../../../utils/next_screen.dart';

class WordScreen extends StatefulWidget {
  const WordScreen({
    super.key,
    required this.word,
  });

  final VocabularyInfo word;

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> wordExample = [];
    VocabularyInfo word = widget.word;

    if (word.sentenceInfos!.isNotEmpty) {
      word.sentenceInfos!.map((e) {
        wordExample.add(exampleItem(e));
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          '${word.traditional}',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () =>
                  NextScreen.iOS(context, const SearchWordScreen()),
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  '${word.simplified}',
                  style: TextStyle(fontSize: 200),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('simplified'.tr(), style: Theme.of(context).textTheme.titleMedium,),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                '${word.simplified}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text('${word.pinyinTones}',
                                  style: Theme.of(context).textTheme.bodyLarge),
                              const SizedBox(
                                width: 16,
                              ),
                              AudioSpeaker(
                                url: word.audioLink!,
                                size: 30,
                              ),
                            ],
                          ),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('traditional'.tr(), style: Theme.of(context).textTheme.titleMedium,),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${word.traditional}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('meaning'.tr(), style: Theme.of(context).textTheme.titleMedium,),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${word.translationVn}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('example'.tr(), style: Theme.of(context).textTheme.titleMedium,),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: word.sentenceInfos!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${index + 1}.${word.sentenceInfos![index].chineseSentence}'),
                                  if (word.sentenceInfos![index].audioLink != null) AudioSpeaker(url: word.sentenceInfos![index].audioLink!,),
                                ],
                              ),
                              if (word.sentenceInfos![index].pinyionSentence != null) Text(' ${word.sentenceInfos![index].pinyionSentence}'),
                              if (word.sentenceInfos![index].translationVn != null) Text('=> ${word.sentenceInfos![index].translationVn}'),],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget exampleItem(SentenceInfo sentence) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${sentence.chineseSentence}'),
        Text('${sentence.chineseSentence}'),
        Text('${sentence.chineseSentence}'),
        Text('${sentence.chineseSentence}'),
      ],
    );
  }
}
