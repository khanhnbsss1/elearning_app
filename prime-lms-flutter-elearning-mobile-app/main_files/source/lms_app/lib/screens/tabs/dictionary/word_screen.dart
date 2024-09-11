import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../base/widgets/audio/audio_speaker.dart';
import '../../../services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';

class WordScreen extends StatefulWidget {
  const WordScreen({super.key, required this.word, });
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
        title: Text(word.translationVn!),
      ),
    );
  }
}
