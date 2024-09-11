import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/base/widgets/audio/audio_speaker.dart';
import 'package:lms_app/services/apis/question/models/question_info.dart';
import 'package:lms_app/services/apis/scores/models/score_info.dart';
import 'quiz_screen.dart';

class OptionTile extends StatefulWidget {
  const OptionTile({
    super.key,
    required this.ref,
    required this.answer,
    required this.questionIndex,
    this.selectedOption,
    required this.optionIndex,
    required this.question,
  });
  final WidgetRef ref;
  final QuestionInfo question;
  final AnswerInfo answer;
  final int questionIndex;
  final int? selectedOption;
  final int optionIndex;

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isSelected =
        widget.selectedOption != null && widget.optionIndex == widget.selectedOption;
    AnswerInfo answer = widget.answer;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: (answer.typeAnswer != "Fill") ? RadioListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            groupValue: widget.ref.watch(selectedOptionProvider),
            title: answer.typeAnswer == "Text"
                ? Text(
              answer.answer![widget.optionIndex],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w500),
                  )
                : answer.typeAnswer == "Image" ? Image.network(answer.typeAnswer!)
                : answer.typeAnswer == "Audio" ? AudioSpeaker(url: answer.answer!)
                : SizedBox(),
            tileColor: _tileColor(
              context,
              isSelected,
            ),
            value: widget.optionIndex,
            activeColor: Colors.white,
            secondary: _trailingIcon(
              isSelected,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            onChanged: (int? value) => _onChanged(value, widget.ref, widget.questionIndex, answer, controller.text))
        : TextFormField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
              hintText: "Please fill in your answer"
          ),

        ),
      ),
    );
  }

  void _onChanged(int? value, WidgetRef ref, int questionIndex,AnswerInfo answer, String answerText) {
    ref.read(selectedOptionProvider.notifier).update((state) => value);
    ref.read(selectedAnswerProvider.notifier).update((state)  {
      List<ScoreItem> list = state;
      list.add(ScoreItem(
        questionId: widget.question.id,
        answerId: answer.answerId,
        questionType: widget.question.typeQuestion!.toLowerCase() == "audio" ? QuestionType.audio :
        widget.question.typeQuestion!.toLowerCase() == "text" ? QuestionType.text :
        widget.question.typeQuestion!.toLowerCase() == "image" ? QuestionType.image :
        QuestionType.fill
      ));
      return list;
    });
  }

  Icon? _trailingIcon(
    bool isSelected,
  ) {
    if (!isSelected) {
      return null;
    } else {
      return const Icon(Icons.clear, color: Colors.white);
    }
  }

  Color _tileColor(
    BuildContext context,
    bool isSelected,
  ) {
    if (!isSelected) {
      return Theme.of(context).scaffoldBackgroundColor;
    } else {
      return Colors.blue;
    }
  }
}
