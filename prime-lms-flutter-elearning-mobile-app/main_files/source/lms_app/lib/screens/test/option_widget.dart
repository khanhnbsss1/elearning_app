import 'package:flutter/material.dart';

import '../../base/widgets/audio/audio_speaker.dart';
import '../../services/apis/question/models/question_info.dart';

class OptionWidget extends StatefulWidget {
  const OptionWidget({super.key, required this.answer});

  final List<AnswerInfo> answer;

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  int? _value;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.answer.map((answer) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: ChoiceChip(
              label: answer.typeAnswer == "Text"
                  ? Text(answer.answer ?? "-")
                  : Image.network(answer.typeAnswer!),
              selected: _value == widget.answer.indexOf(answer),
              selectedColor: Colors.blueAccent,
              onSelected: (selected) {
                setState(() {
                  _value = selected ? widget.answer.indexOf(answer) : null;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}