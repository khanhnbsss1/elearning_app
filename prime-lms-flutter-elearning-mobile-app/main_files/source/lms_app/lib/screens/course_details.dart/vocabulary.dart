import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lms_app/ads/ad_manager.dart';
import 'package:lms_app/base/widgets/common/alert_dialog/loading.common.dart';
import 'package:lms_app/constants/app_constants.dart';
import 'package:lms_app/mixins/course_mixin.dart';
import 'package:lms_app/mixins/user_mixin.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/services/apis/lessson/models/lesson_info.dart';
import 'package:lms_app/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:lms_app/services/apis/vocabulary/vocabulary_list/vocabulary_list_api.dart';
import '../../base/widgets/audio/audio_speaker.dart';
import '../../utils/next_screen.dart';
import '../tabs/dictionary/word_screen.dart';

class Vocabulary extends ConsumerWidget with CourseMixin, UserMixin {
  const Vocabulary(
      {super.key, required this.lessonDetail, required this.sectionId});

  final LessonInfo lessonDetail;
  final int sectionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          '${lessonDetail.lectureName}',
          maxLines: 2,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          if (lessonDetail.vocabularies != null) ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 0, bottom: 20),
                  itemCount: lessonDetail.vocabularies!.length,
                  itemBuilder: (context, index) {
                    final VocabularyInfo word =
                        lessonDetail.vocabularies![index];
                    return ListTile(
                      onTap: () {
                        showWord(context, word);
                      },
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      horizontalTitleGap: 10,
                      title: Text(
                        word.simplified!,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      subtitle: (word.translationVn != "")
                          ? Text(word.translationVn ?? "-")
                          : const Text("-"),
                      leading: Text(
                        '${index + 1}.',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      trailing: AudioSpeaker(
                        url: word.audioLink ?? "",
                        enableProccessBar: false,
                      ),
                    );
                  },
                ),
        ]),
      ),
    );
  }

  Future<void> showWord(BuildContext context, VocabularyInfo word) async {
    MonitorLoading().showLoading('');
    VocabularyInfo wordDetail = await ApiService().getVocabularyDetail(word.id??0);
    MonitorLoading().dismiss();
    if (wordDetail.simplified != null) {
      NextScreen.normal(context, WordScreen(word: wordDetail));
    } else {
      NextScreen.normal(context, WordScreen(word: word));
    }
  }
}
