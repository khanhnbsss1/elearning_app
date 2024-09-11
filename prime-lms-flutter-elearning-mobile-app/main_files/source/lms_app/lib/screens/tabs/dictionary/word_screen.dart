import 'package:flutter/material.dart';
import 'package:lms_app/screens/tabs/dictionary/search_word/search_word_view.dart';
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
    VocabularyInfo word = widget.word;
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
          icon: Icon(
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
              icon: Icon(
                Icons.search,
                color: Colors.white,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
                child: Text(
              '${word.traditional}',
              style: Theme.of(context).textTheme.titleLarge,
            )),
          ],
        ),
      ),
    );
  }
}
