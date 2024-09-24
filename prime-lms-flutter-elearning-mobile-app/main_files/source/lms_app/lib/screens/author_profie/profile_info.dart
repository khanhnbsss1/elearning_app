import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/user_avatar.dart';
import '../../models/user_model.dart';
import '../../models/user/UserProfile.dart';
import '../../services/apis/teacher_list/models/landing_page_teacher_list_model.dart';
import '../../services/apis/teacher_list/models/teacher_model.dart';
import '../../services/app_service.dart';
import 'count_info.dart';

class AuthorProfileInfo extends StatelessWidget {
  const AuthorProfileInfo({
    super.key,
    required this.teacherDetail,
  });

  final TeacherDetail teacherDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
      child: Column(
        children: [
          UserAvatar(
            imageUrl: teacherDetail.avatar,
            radius: 100,
            iconSize: 60,
          ),
          const SizedBox(height: 10),
          Text(
            teacherDetail.fullName ?? "-",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            teacherDetail.position ?? "-",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: teacherDetail.website != null,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.globe,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () => AppService()
                        .openLink(teacherDetail.website ?? "https://www.google.com/"),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Visibility(
                visible: teacherDetail.facebook != null,
                // visible: true,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.facebook,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () => AppService()
                        .openLink(teacherDetail.facebook ?? "https://www.facebook.com/"),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Visibility(
                visible: teacherDetail.twitter != null,
                // visible: true,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.xTwitter,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () => AppService()
                        .openLink(teacherDetail.twitter ?? "https://x.com/?lang=vi"),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Visibility(
                visible: teacherDetail.youtube != null,
                // visible: true,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.youtube,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () => AppService()
                        .openLink(teacherDetail.youtube ?? "https://www.youtube.com/"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EnableDisableWidget extends StatelessWidget {
  final bool isEnabled;
  final Widget child;

  const EnableDisableWidget({super.key, required this.isEnabled, required this.child});

  @override
  Widget build(BuildContext context) {
    return isEnabled
        ? child
        : Opacity(
            opacity: 0.6,
            child: IgnorePointer(
              child: child,
            ),
          );
  }
}
