import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/services/apis/question/models/question_info.dart';
import 'package:lms_app/services/apis/scores/models/score_info.dart';
import 'quiz_screen.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.ref,
    required this.answer,
    required this.questionIndex,
    this.selectedOption,
    required this.optionIndex,
  });

  final WidgetRef ref;
  final AnswerInfo answer;
  final int questionIndex;
  final int? selectedOption;
  final int optionIndex;

  @override
  Widget build(BuildContext context) {
    final bool isSelected =
        selectedOption != null && optionIndex == selectedOption;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: RadioListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            groupValue: ref.watch(selectedOptionProvider),
            title: answer.typeAnswer == "Text"
                ? Text(
                    answer.answer![optionIndex],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w500),
                  )
                : Image.network(answer.typeAnswer!),
            tileColor: _tileColor(
              context,
              isSelected,
            ),
            value: optionIndex,
            activeColor: Colors.white,
            secondary: _trailingIcon(
              isSelected,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            onChanged: selectedOption != null
                ? null
                : (int? value) => _onChanged(value, ref, questionIndex)),
      ),
    );
  }

  void _onChanged(int? value, WidgetRef ref, int questionIndex) {
    ref.read(selectedOptionProvider.notifier).update((state) => value);

    //Initiating corrct Answer count
    if (questionIndex == 0) {
      ref.invalidate(correctAnswerCountProvider);
    }
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
