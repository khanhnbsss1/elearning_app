import 'package:flutter/cupertino.dart';
import 'package:lms_app/screens/test/option_widget.dart';
import 'package:lms_app/services/apis/question/models/question_info.dart';

import '../../base/widgets/audio/audio_speaker.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({super.key, required this.question, required this.index});

  final QuestionInfo question;
  final int index;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  @override
  Widget build(BuildContext context) {
    QuestionInfo question = widget.question;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all()
        ),
        child: Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.index+1}) ${question.questionName} (${question.weightage}pts)'),
              question.typeQuestion == "Text"
                  ? Text(question.questionName ?? "-")
                  : question.typeQuestion == "Audio"
                      ? AudioSpeaker(
                          url: question.questionLink!,
                          enableProccessBar: true,
                        )
                      : Image.network(question.questionLink!),
              const SizedBox(
                height: 8,
              ),
              OptionWidget(answer: question.answer!),
            ],
          ),
        ),
      ),
    );
  }
}
